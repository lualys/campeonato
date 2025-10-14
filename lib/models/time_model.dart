class TimeModel {
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
}
