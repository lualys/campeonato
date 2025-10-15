class TimeModel {
  final int posicao;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsPro;
  final int golsContra;
  final int saldoGols;
  final String ultimosJogos;
  final String nome;
  final String escudo;

  TimeModel({
    required this.posicao,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsPro,
    required this.golsContra,
    required this.saldoGols,
    required this.ultimosJogos,
    required this.nome,
    required this.escudo,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      posicao: json['posicao'],
      pontos: json['pontos'],
      jogos: json['jogos'],
      vitorias: json['vitorias'],
      empates: json['empates'],
      derrotas: json['derrotas'],
      golsPro: json['gols_pro'],
      golsContra: json['gols_contra'],
      saldoGols: json['saldo_gols'],
      ultimosJogos: json['ultimos_jogos'],
      nome: json['time']['nome_popular'],
      escudo: json['time']['escudo'],
    );
  }
}
