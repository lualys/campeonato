import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/times_provider.dart';
import '/models/time_model.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  String filtro = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimesProvider>(context);
    final times = provider.timesFiltrados(filtro);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🏆 Brasileirão 2025',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
      ),
      body: provider.carregando
          ? const Center(child: CircularProgressIndicator())
          : provider.erro != null
              ? Center(child: Text(provider.erro!))
              : Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 102, 8, 118),
                        Colors.pinkAccent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Buscar time...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) => setState(() => filtro = value),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: times.length,
                          itemBuilder: (context, index) {
                            final time = times[index];
                            final posicao = index + 1;

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: ListTile(
                                leading: Hero(
                                  tag: 'escudo_${time.id}',
                                  child: Image.asset(
                                    time.escudo,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                title: Text(
                                  '$posicao. ${time.nome}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${time.pontos} pts | ${time.vitorias}V ${time.empates}E ${time.derrotas}D',
                                  style: TextStyle(color: Colors.grey[200]),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${time.saldoGols >= 0 ? '+' : ''}${time.saldoGols}',
                                      style: TextStyle(
                                        color: time.saldoGols >= 0
                                            ? Colors.lightGreenAccent
                                            : Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: Icon(
                                        provider.isFavorito(time.id)
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color: provider.isFavorito(time.id)
                                            ? Colors.amber
                                            : Colors.white,
                                      ),
                                      onPressed: () =>
                                          provider.alternarFavorito(time.id),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detalhes',
                                    arguments: time,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
