import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/time_model.dart';
import 'pages/classificacao_page.dart';
import 'pages/detalhes_time_page.dart';

void main() {
  runApp(const BrasileiraoApp());
}

class TimesProvider with ChangeNotifier {
  List<TimeModel> times = [];

  void setTimes(List<TimeModel> novos) {
    times = novos;
    notifyListeners();
  }

  TimeModel? getById(int id) =>
      times.firstWhere((t) => t.id == id, orElse: () => times.first);
}

class BrasileiraoApp extends StatelessWidget {
  const BrasileiraoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brasileirão 2025',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const ClassificacaoPage(),
          '/detalhes': (_) => const DetalhesTimePage(),
        },
      ),
    );
  }
}
