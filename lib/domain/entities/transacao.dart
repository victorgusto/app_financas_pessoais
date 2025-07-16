import 'package:equatable/equatable.dart';

enum TipoTransacao { entrada, saida }

class Transacao extends Equatable {
  final String id;
  final String descricao;
  final double valor;
  final DateTime data;
  final TipoTransacao tipo;

  const Transacao({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.data,
    required this.tipo,
  });

  Transacao copyWith({
    String? id,
    String? descricao,
    double? valor,
    DateTime? data,
    TipoTransacao? tipo,
  }) {
    return Transacao(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      data: data ?? this.data,
      tipo: tipo ?? this.tipo,
    );
  }

  @override
  List<Object?> get props => [id, descricao, valor, data, tipo];
}
