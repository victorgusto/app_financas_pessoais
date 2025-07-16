import 'package:equatable/equatable.dart';
import 'package:financas_pessoais/domain/entities/transacao.dart';

abstract class NovaTransacaoEvent extends Equatable {
  const NovaTransacaoEvent();

  @override
  List<Object> get props => [];
}

class NovaTransacaoSubmitted extends NovaTransacaoEvent {
  final Transacao transacao;

  const NovaTransacaoSubmitted(this.transacao);

  @override
  List<Object> get props => [transacao];
} 