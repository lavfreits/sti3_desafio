import 'order_item.dart';
import 'payment.dart';

class Order {
  final String id;
  final String numero;
  final String dataCriacao;
  final String dataAlteracao;
  final String status;
  final String desconto;
  final String frete;
  final String subTotal;
  final String valorTotal;
  final List<OrderItem> itens;
  final List<Payment> pagamentos;
  final String nomeCliente;
  final String emailCliente;

  Order({
    required this.id,
    required this.numero,
    required this.dataCriacao,
    required this.dataAlteracao,
    required this.status,
    required this.desconto,
    required this.frete,
    required this.subTotal,
    required this.valorTotal,
    required this.itens,
    required this.pagamentos,
    required this.nomeCliente,
    required this.emailCliente,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'numero': numero,
        'frete': frete,
        'dataCriacao': dataCriacao.toString(),
        'dataAlteracao': dataAlteracao.toString(),
        'status': status,
        'desconto': desconto,
        'valorTotal': valorTotal,
        'subTotal': subTotal,
        'itens': itens.map((item) => item.toJson()).toList(),
        'pagamento': pagamentos.map((pagamento) => pagamento.toJson()).toList(),
        'cliente': {'nome': nomeCliente, 'email': emailCliente},
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        numero: json['numero'].toString(),
        dataCriacao: json['dataCriacao'].toString(),
        dataAlteracao: json['dataAlteracao'].toString(),
        status: json['status'],
        desconto: json['desconto'].toString(),
        frete: json['frete'].toString(),
        valorTotal: json['valorTotal'].toString(),
        subTotal: json['subTotal'].toString(),
        itens: List<OrderItem>.from(
            json['itens'].map((item) => OrderItem.fromJson(item))),
        pagamentos: List<Payment>.from(
            json['pagamento'].map((pagamento) => Payment.fromJson(pagamento))),
        nomeCliente: json['cliente']['nome'],
        emailCliente: json['cliente']['email'],
      );
}
