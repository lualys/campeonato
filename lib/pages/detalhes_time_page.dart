import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_model.dart';
import '../main.dart';

class DetalhesTimePage extends StatelessWidget {
  const DetalhesTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final provider = Provider.of<TimesProvider>(context, listen: false);

    TimeModel? time;
    if (args is TimeModel) {
      time = args;
    } else if (args is int) {
      time = provider.getById(args);
    }

    if (time == null) {
      return const Scaffold(
        body: Center(child: Text("Time não encontrado.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(time.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: time.id,
              child: Image.asset(time.escudo, height: 120),
            ),
            const SizedBox(height: 16),
            Text(
              "Estatísticas 2025",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _stat("Jogos", time.jogos),
            _stat("Vitórias", time.vitorias),
            _stat("Empates", time.empates),
            _stat("Derrotas", time.derrotas),
            _stat("Gols Pró", time.golsPro),
            _stat("Gols Contra", time.golsContra),
            _stat("Saldo de Gols", time.saldoGols),
            const Divider(height: 32),
            Text("Títulos Brasileiros:",
                style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              children: time.titulos
                  .map((ano) => Chip(label: Text(ano.toString())))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String nome, int valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(nome),
        Text(valor.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
