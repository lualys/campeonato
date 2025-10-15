import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/time_model.dart';

class DetalhesTimePage extends StatelessWidget {
  final TimeModel time;
  final Map<String, dynamic> detalhes;

  const DetalhesTimePage({
    required this.time,
    required this.detalhes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final estadio = detalhes['estadio']?['nome_popular'] ?? 'Desconhecido';
    final cidade = detalhes['estadio']?['cidade'] ?? '';
    final elenco = detalhes['elenco'] ?? [];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(time.nome),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade800, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      time.escudo,
                      height: 120,
                      width: 120,
                    ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  _infoRow('Pontos', time.pontos),
                  _infoRow('Jogos', time.jogos),
                  _infoRow('Vitórias', time.vitorias),
                  _infoRow('Empates', time.empates),
                  _infoRow('Derrotas', time.derrotas),
                  _infoRow('Saldo de Gols', time.saldo),
                  const SizedBox(height: 20),
                  Text('Estádio: $estadio - $cidade', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey),
                  const Text('Últimos 5 jogos', style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: time.ultimos5.map((r) {
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
                        padding: const EdgeInsets.all(4),
                        child: Icon(icone, color: cor, size: 22),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text('Elenco', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...elenco.map((jogador) {
                    return Card(
                      color: Colors.grey[900],
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.person, color: Colors.white70),
                        title: Text(jogador['nome_popular'] ?? 'Jogador', style: const TextStyle(color: Colors.white)),
                        subtitle: Text(jogador['posicao'] ?? '', style: const TextStyle(color: Colors.white54)),
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _infoRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text('$value', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
