class TimeModel {
  final int posicao;
  final String nome;
  final String escudo;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsMarcados;
  final int golsSofridos;
  final int saldo;
  final List<String> ultimos5;

  TimeModel({
    required this.posicao,
    required this.nome,
    required this.escudo,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsMarcados,
    required this.golsSofridos,
    required this.saldo,
    required this.ultimos5,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    final time = json['time'] ?? {};
    final ultimos5 = (json['ultimos_jogos'] ?? '')
        .toString()
        .split('')
        .where((e) => e.trim().isNotEmpty)
        .toList();

    return TimeModel(
      posicao: json['posicao'] ?? 0,
      nome: time['nome_popular'] ?? '',
      escudo: time['escudo'] ?? '',
      pontos: json['pontos'] ?? 0,
      jogos: json['jogos'] ?? 0,
      vitorias: json['vitorias'] ?? 0,
      empates: json['empates'] ?? 0,
      derrotas: json['derrotas'] ?? 0,
      golsMarcados: json['gols_pro'] ?? 0,
      golsSofridos: json['gols_contra'] ?? 0,
      saldo: json['saldo_gols'] ?? 0,
      ultimos5: ultimos5,
    );
  }
}
