import 'package:flutter/material.dart';
import '/pages/classificacao_page.dart';

void main() {
  runApp(const AppClassificacao());
}

class AppClassificacao extends StatelessWidget {
  const AppClassificacao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classificação Brasileirao 2025',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ClassificacaoPage(),
    );
  }
}
