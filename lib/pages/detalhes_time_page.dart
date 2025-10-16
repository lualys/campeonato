import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_model.dart';
import '../providers/times_provider.dart';

class DetalhesTimePage extends StatelessWidget {
  const DetalhesTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final time = ModalRoute.of(context)!.settings.arguments as TimeModel;
    final provider = Provider.of<TimesProvider>(context);
    final favorito = provider.isFavorito(time.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(time.nome),
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              favorito ? Icons.star : Icons.star_border,
              color: favorito ? Colors.amber : Colors.white,
            ),
            onPressed: () => provider.alternarFavorito(time.id),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(time.escudo, fit: BoxFit.contain),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Hero(
                    tag: 'escudo_${time.id}',
                    child: Image.asset(
                      time.escudo,
                      width: 80, // largura do escudo
                      height: 80, // altura do escudo
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    time.nome,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 5,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.white, width: 2)),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text('📊 Estatísticas da Temporada',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white)),
                          const Divider(color: Colors.white),
                          _infoRow('Pontos', time.pontos.toString()),
                          _infoRow('Jogos', time.jogos.toString()),
                          _infoRow('Vitórias', time.vitorias.toString()),
                          _infoRow('Empates', time.empates.toString()),
                          _infoRow('Derrotas', time.derrotas.toString()),
                          _infoRow('Gols Pró', time.golsPro.toString()),
                          _infoRow('Gols Contra', time.golsContra.toString()),
                          _infoRow('Saldo de Gols', time.saldoGols.toString(),
                              saldo: time.saldoGols),
                        ],
                      ),
                    ),
                  ),
                  if (time.titulos.isNotEmpty)
                    Card(
                      elevation: 5,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: Colors.white, width: 2)),
                      margin: const EdgeInsets.only(top: 8, bottom: 32),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text('🏅 Títulos Brasileiros',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white)),
                            const Divider(color: Colors.white),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: time.titulos
                                  .map((ano) => Chip(
                                        label: Text(
                                          ano.toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        backgroundColor: Colors.purpleAccent
                                            .withOpacity(0.7),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String valor, {int? saldo}) {
    Color corValor = Colors.white;
    if (saldo != null) {
      corValor = saldo >= 0 ? Colors.lightGreenAccent : Colors.redAccent;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          Text(valor,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: corValor)),
        ],
      ),
    );
  }
}
