import 'package:flutter/material.dart';
import '../models/time_model.dart';
import 'detalhes_time_page.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ClassificacaoPage extends StatelessWidget {
  final List<TimeModel> times = [
    TimeModel(
      nome: 'Palmeiras',
      escudo: 'assets/palmeiras.png',
      pontos: 58,
      jogos: 26,
      vitorias: 18,
      empates: 4,
      derrotas: 4,
      golsMarcados: 46,
      golsSofridos: 22,
      saldo: 24,
      ultimos5: ['V', 'V', 'D', 'V', 'E'],
    ),
    TimeModel(
      nome: 'Flamengo',
      escudo: 'assets/flamengo.png',
      pontos: 55,
      jogos: 26,
      vitorias: 16,
      empates: 7,
      derrotas: 3,
      golsMarcados: 50,
      golsSofridos: 13,
      saldo: 37,
      ultimos5: ['V', 'E', 'V', 'V', 'D'],
    ),
    TimeModel(
      nome: 'Cruzeiro',
      escudo: 'assets/cruzeiro.png',
      pontos: 52,
      jogos: 27,
      vitorias: 15,
      empates: 7,
      derrotas: 5,
      golsMarcados: 40,
      golsSofridos: 20,
      saldo: 20,
      ultimos5: ['V', 'D', 'E', 'V', 'D'],
    ),
  ];

  Future<void> mostrarInfoDispositivo(BuildContext context) async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final modelo = androidInfo.model;
    final fabricante = androidInfo.manufacturer;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Informações do Dispositivo'),
        content: Text('Fabricante: $fabricante\nModelo: $modelo'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Classificação 2025'),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => mostrarInfoDispositivo(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            color: Colors.grey[850],
            child: Row(
              children: const [
                Expanded(flex: 3, child: Text('Clube', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                Expanded(child: Center(child: Text('Pts', style: TextStyle(color: Colors.white)))),
                Expanded(child: Center(child: Text('PJ', style: TextStyle(color: Colors.white)))),
                Expanded(child: Center(child: Text('VIT', style: TextStyle(color: Colors.white)))),
                Expanded(child: Center(child: Text('E', style: TextStyle(color: Colors.white)))),
                Expanded(child: Center(child: Text('DER', style: TextStyle(color: Colors.white)))),
                Expanded(child: Center(child: Text('GM', style: TextStyle(color: Colors.white)))),
                Expanded(child: Center(child: Text('GC', style: TextStyle(color: Colors.white)))),
                Expanded(child: Center(child: Text('SG', style: TextStyle(color: Colors.white)))),
                Expanded(flex: 2, child: Center(child: Text('Últimas 5', style: TextStyle(color: Colors.white)))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: times.length,
              itemBuilder: (context, index) {
                final t = times[index];
                return InkWell(
                  onTap: () async {
                    final deviceInfo = DeviceInfoPlugin();
                    final androidInfo = await deviceInfo.androidInfo;
                    final modelo = androidInfo.model;
                    final fabricante = androidInfo.manufacturer;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhesTimePage(
                          time: t,
                          modeloDispositivo: "$fabricante $modelo",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      border: Border(bottom: BorderSide(color: Colors.grey[800]!)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Text('${index + 1}', style: const TextStyle(color: Colors.white70)),
                              const SizedBox(width: 6),
                              Image.asset(t.escudo, width: 25),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(t.nome, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Center(child: Text('${t.pontos}', style: const TextStyle(color: Colors.white)))),
                        Expanded(child: Center(child: Text('${t.jogos}', style: const TextStyle(color: Colors.white)))),
                        Expanded(child: Center(child: Text('${t.vitorias}', style: const TextStyle(color: Colors.white)))),
                        Expanded(child: Center(child: Text('${t.empates}', style: const TextStyle(color: Colors.white)))),
                        Expanded(child: Center(child: Text('${t.derrotas}', style: const TextStyle(color: Colors.white)))),
                        Expanded(child: Center(child: Text('${t.golsMarcados}', style: const TextStyle(color: Colors.white)))),
                        Expanded(child: Center(child: Text('${t.golsSofridos}', style: const TextStyle(color: Colors.white)))),
                        Expanded(child: Center(child: Text('${t.saldo}', style: const TextStyle(color: Colors.white)))),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: t.ultimos5.map((r) {
                              Color cor;
                              if (r == 'V') cor = Colors.green;
                              else if (r == 'D') cor = Colors.red;
                              else cor = Colors.grey;
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
