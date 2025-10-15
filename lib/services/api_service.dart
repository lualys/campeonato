import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/time_model.dart';

class ApiService {
  final String baseUrl = 'https://api.api-futebol.com.br/v1';
  final String token;

  ApiService({required this.token});

  Future<List<TimeModel>> getTabela(int campeonatoId) async {
    final url = Uri.parse('$baseUrl/campeonatos/$campeonatoId/tabela');
    final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => TimeModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar tabela: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getTimeDetalhes(int timeId) async {
    final url = Uri.parse('$baseUrl/times/$timeId');
    final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar detalhes do time');
    }
  }
}
