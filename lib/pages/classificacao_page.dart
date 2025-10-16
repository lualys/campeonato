import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/time_model.dart';
import '../main.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  List<TimeModel> _times = [];
  List<TimeModel> _filtered = [];
  bool _loading = true;
  bool _error = false;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTimes();
  }

  Future<void> _loadTimes() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/times.json');
      final data = jsonDecode(jsonStr)['times'] as List;
      final times = data.map((e) => TimeModel.fromJson(e)).toList()
        ..sort((a, b) => b.pontos.compareTo(a.pontos));

      Provider.of<TimesProvider>(context, listen: false).setTimes(times);
      setState(() {
        _times = times;
        _filtered = times;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = true;
        _loading = false;
      });
    }
  }

  void _filter(String query) {
    setState(() {
      _filtered = _times
          .where((t) => t.nome.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Color _getZoneColor(int pos) {
    if (pos < 4) return Colors.green;
    if (pos < 6) return Colors.lightGreen;
    if (pos >= 16) return Colors.red;
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error) {
      return const Scaffold(
          body: Center(child: Text("Erro ao carregar dados.")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Classificação"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(
                hintText: 'Buscar time...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filter,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final t = _filtered[i];
                final pos = _times.indexOf(t) + 1;
                return Card(
                  color: _getZoneColor(pos),
                  child: ListTile(
                    leading: Hero(
                      tag: t.id,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(t.escudo),
                      ),
                    ),
                    title: Text("$posº ${t.nome}"),
                    subtitle: Text("Pontos: ${t.pontos}"),
                    onTap: () =>
                        Navigator.pushNamed(context, '/detalhes', arguments: t),
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
