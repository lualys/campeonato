import 'package:flutter/material.dart';
import 'pages/classificacao_page.dart';
import 'services/api_service.dart';

final apiService = ApiService(
  token: 'live_8877b82245e6a480f48a377d63cdf5', // substitua pelo seu token
);

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ClassificacaoPage(),
    );
  }
}
