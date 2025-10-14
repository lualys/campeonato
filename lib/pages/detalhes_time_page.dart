import 'package:flutter/material.dart';
import '../models/time_model.dart';

class DetalhesTimePage extends StatelessWidget {
  final TimeModel time;
  final String modeloDispositivo;

  const DetalhesTimePage({
    required this.time,
    required this.modeloDispositivo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(time.nome),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(time.escudo, width: 100),
            const SizedBox(height: 20),
            Text('Pontos: ${time.pontos}', style: const TextStyle(color: Colors.white)),
            Text('Jogos: ${time.jogos}', style: const TextStyle(color: Colors.white)),
            Text('Vitórias: ${time.vitorias}', style: const TextStyle(color: Colors.white)),
            Text('Empates: ${time.empates}', style: const TextStyle(color: Colors.white)),
            Text('Derrotas: ${time.derrotas}', style: const TextStyle(color: Colors.white)),
            Text('Gols Marcados: ${time.golsMarcados}', style: const TextStyle(color: Colors.white)),
            Text('Gols Sofridos: ${time.golsSofridos}', style: const TextStyle(color: Colors.white)),
            Text('Saldo de Gols: ${time.saldo}', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            Divider(color: Colors.grey[700]),
            Text(
              'Exibido no dispositivo:',
              style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
            ),
            Text(
              modeloDispositivo,
              style: const TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
