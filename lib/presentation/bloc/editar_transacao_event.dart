import 'package:equatable/equatable.dart';
import 'package:financas_pessoais/domain/entities/transacao.dart';

abstract class EditarTransacaoEvent extends Equatable {
  const EditarTransacaoEvent();

  @override
  List<Object?> get props => [];
}

class EditarTransacaoSubmitted extends EditarTransacaoEvent {
  final Transacao transacao;

  const EditarTransacaoSubmitted(this.transacao);

  @override
  List<Object?> get props => [transacao];
}

class ExcluirTransacaoSubmitted extends EditarTransacaoEvent {
  final String transacaoId;

  const ExcluirTransacaoSubmitted(this.transacaoId);

  @override
  List<Object?> get props => [transacaoId];
} 