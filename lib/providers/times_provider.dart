import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/time_model.dart';

class TimesProvider extends ChangeNotifier {
  List<TimeModel> _times = [];
  bool carregando = false;
  String? erro;
  Set<int> _favoritos = {};

  List<TimeModel> get times => _times;

  Future<void> carregarTimes() async {
    carregando = true;
    erro = null;
    notifyListeners();

    try {
      final jsonString = await rootBundle.loadString('assets/times.json');
      final jsonData = json.decode(jsonString);
      _times = (jsonData['times'] as List)
          .map((item) => TimeModel.fromJson(item))
          .toList();
      await _carregarFavoritos();
    } catch (e) {
      erro = 'Erro ao carregar dados: $e';
    }

    carregando = false;
    notifyListeners();
  }

  List<TimeModel> timesFiltrados(String filtro) {
    final lista = [..._times];
    lista.sort((a, b) => b.pontos.compareTo(a.pontos));
    if (filtro.isEmpty) return lista;
    return lista
        .where((t) => t.nome.toLowerCase().contains(filtro.toLowerCase()))
        .toList();
  }

  bool isFavorito(int id) => _favoritos.contains(id);

  Future<void> alternarFavorito(int id) async {
    if (_favoritos.contains(id)) {
      _favoritos.remove(id);
    } else {
      _favoritos.add(id);
    }
    notifyListeners();
    await _salvarFavoritos();
  }

  Future<void> _carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    _favoritos = prefs.getStringList('favoritos')?.map(int.parse).toSet() ?? {};
    notifyListeners();
  }

  Future<void> _salvarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'favoritos', _favoritos.map((id) => id.toString()).toList());
  }
}
