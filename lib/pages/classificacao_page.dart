import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/time_model.dart';
import 'detalhes_time_page.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  final ApiService api = ApiService();
  late Future<List<TimeModel>> futureTabela;

  @override
  void initState() {
    super.initState();
    futureTabela = api.getTabelaLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classificação Brasileirão 2025'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TimeModel>>(
        future: futureTabela,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          final tabela = snapshot.data ?? [];

          return ListView.builder(
            itemCount: tabela.length,
            itemBuilder: (context, index) {
              final time = tabela[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(time.escudo),
                  backgroundColor: Colors.transparent,
                ),
                title: Text('${time.posicao}. ${time.nome}'),
                subtitle: Text(
                  'P: ${time.pontos} | J: ${time.jogos} | SG: ${time.saldoGols}',
                ),
                trailing: Text(
                  '${time.pontos} pts',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalhesTimePage(time: time),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
