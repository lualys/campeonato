import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/time_model.dart';
import '../services/api_service.dart';
import '../main.dart';
import 'detalhes_time_page.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  late Future<List<TimeModel>> futureTabela;

  @override
  void initState() {
    super.initState();
    futureTabela = apiService.getTabela(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🇧🇷 Brasileirão 2025'),
        backgroundColor: Colors.green[900],
      ),
      body: FutureBuilder<List<TimeModel>>(
        future: futureTabela,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}', style: const TextStyle(color: Colors.redAccent)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum dado disponível', style: TextStyle(color: Colors.white70)));
          }

          final times = snapshot.data!;

          return ListView.builder(
            itemCount: times.length,
            itemBuilder: (context, index) {
              final t = times[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(t.escudo),
                    radius: 20,
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    '${t.posicao}. ${t.nome}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    children: t.ultimos5.map((r) {
                      IconData icone;
                      Color cor;
                      if (r == 'V') {
                        icone = Icons.check_circle;
                        cor = Colors.green;
                      } else if (r == 'E') {
                        icone = Icons.remove_circle;
                        cor = Colors.grey;
                      } else {
                        icone = Icons.cancel;
                        cor = Colors.red;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(icone, color: cor, size: 16),
                      );
                    }).toList(),
                  ),
                  trailing: Text(
                    '${t.pontos} pts',
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () async {
                    final detalhes = await apiService.getTimeDetalhes(t.posicao);
                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhesTimePage(time: t, detalhes: detalhes),
                      ),
                    );
                  },
                ),
              ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.2);
            },
          );
        },
      ),
    );
  }
}
