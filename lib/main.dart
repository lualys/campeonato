import 'package:flutter/material.dart';
import 'pages/classificacao_page.dart';

void main() {
  runApp(const AppClassificacao());
}

class AppClassificacao extends StatelessWidget {
  const AppClassificacao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classificação Brasileirão 2025',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
          brightness: Brightness.dark,
        ),
      ),
      home: const ClassificacaoPage(),
    );
  }
}
