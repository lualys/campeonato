import 'package:flutter/material.dart';
import '../models/time_model.dart';

class DetalhesTimePage extends StatelessWidget {
  final TimeModel time;

  const DetalhesTimePage({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(time.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Image.network(
                time.escudo,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${time.posicao}º colocado - ${time.pontos} pontos',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),
            _infoRow('Jogos', '${time.jogos}'),
            _infoRow('Vitórias', '${time.vitorias}'),
            _infoRow('Empates', '${time.empates}'),
            _infoRow('Derrotas', '${time.derrotas}'),
            _infoRow('Gols Pró', '${time.golsPro}'),
            _infoRow('Gols Contra', '${time.golsContra}'),
            _infoRow('Saldo de Gols', '${time.saldoGols}'),
            const SizedBox(height: 20),
            _ultimosJogos(time.ultimosJogos),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _ultimosJogos(String ultimosJogos) {
    final cores = {'V': Colors.green, 'E': Colors.orange, 'D': Colors.red};

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ultimosJogos.split('').map((r) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundColor: cores[r] ?? Colors.grey,
            radius: 12,
            child: Text(r, style: const TextStyle(fontSize: 12)),
          ),
        );
      }).toList(),
    );
  }
}
