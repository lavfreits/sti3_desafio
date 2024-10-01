class OrderItem {
  final String id;
  final String idProduto;
  final String nome;
  final String quantidade;
  final String valorUnitario;

  OrderItem({
    required this.id,
    required this.idProduto,
    required this.nome,
    required this.quantidade,
    required this.valorUnitario,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'idProduto': idProduto,
        'nome': nome,
        'quantidade': quantidade,
        'valorUnitario': valorUnitario,
      };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'],
        idProduto: json['idProduto'],
        nome: json['nome'],
        quantidade: json['quantidade'].toString(),
        valorUnitario: json['valorUnitario'].toString(),
      );
}
