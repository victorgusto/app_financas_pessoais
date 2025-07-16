import 'package:hive/hive.dart';
import 'package:financas_pessoais/domain/entities/transacao.dart';

part 'transacao_model.g.dart';

@HiveType(typeId: 0)
class TransacaoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String descricao;

  @HiveField(2)
  final double valor;

  @HiveField(3)
  final DateTime data;

  @HiveField(4)
  final String tipo;

  TransacaoModel({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.data,
    required this.tipo,
  });

  Transacao toEntity() {
    return Transacao(
      id: id,
      descricao: descricao,
      valor: valor,
      data: data,
      tipo: tipo == 'entrada' ? TipoTransacao.entrada : TipoTransacao.saida,
    );
  }

  static TransacaoModel fromEntity(Transacao transacao) {
    return TransacaoModel(
      id: transacao.id,
      descricao: transacao.descricao,
      valor: transacao.valor,
      data: transacao.data,
      tipo: transacao.tipo == TipoTransacao.entrada ? 'entrada' : 'saida',
    );
  }

  @override
  String toString() {
    return 'TransacaoModel(id: $id, descricao: $descricao, valor: $valor, data: $data, tipo: $tipo)';
  }
}
