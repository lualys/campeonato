import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/time_model.dart';

class ApiService {
  /// Carrega a tabela de classificação a partir de um arquivo local (sem token)
  Future<List<TimeModel>> getTabelaLocal() async {
    final jsonStr = await rootBundle.loadString('assets/data/tabela.json');
    final List data = json.decode(jsonStr);
    return data.map((e) => TimeModel.fromJson(e)).toList();
  }

  /// Retorna detalhes simulados de um time (mock local)
  Future<Map<String, dynamic>> getTimeDetalhes(int posicao) async {
    final jsonStr = await rootBundle.loadString('assets/data/tabela.json');
    final List data = json.decode(jsonStr);
    final time = data.firstWhere((e) => e['posicao'] == posicao);
    return time;
  }
}
