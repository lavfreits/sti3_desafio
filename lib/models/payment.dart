class Payment {
  final String id;
  final String parcela;
  final String valor;
  final String nome;

  Payment({
    required this.id,
    required this.parcela,
    required this.valor,
    required this.nome,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'parcela': parcela,
        'valor': valor,
        'nome': nome,
      };

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'],
        parcela: json['parcela'].toString(),
        valor: json['valor'].toString(),
        nome: json['nome'],
      );
}
