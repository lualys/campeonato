import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

import 'models/time_model.dart';
import 'pages/classificacao_page.dart';
import 'pages/detalhes_time_page.dart';
import 'providers/times_provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled:
          !const bool.fromEnvironment('dart.vm.product'), // ativa só em debug
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => TimesProvider()..carregarTimes()),
        ],
        child: const BrasileiraoApp(),
      ),
    ),
  );
}

class BrasileiraoApp extends StatelessWidget {
  const BrasileiraoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brasileirão 2025',
      debugShowCheckedModeBanner: false,
      // 🔹 Integração com DevicePreview
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,

      initialRoute: '/',
      routes: {
        '/': (_) => const ClassificacaoPage(),
        '/detalhes': (_) => const DetalhesTimePage(),
      },
    );
  }
}
