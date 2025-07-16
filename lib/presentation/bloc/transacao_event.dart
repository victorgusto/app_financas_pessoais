import 'package:equatable/equatable.dart';
import 'package:financas_pessoais/domain/entities/transacao.dart';

abstract class TransacaoEvent extends Equatable {
  const TransacaoEvent();

  @override
  List<Object?> get props => [];
}

class CarregarTransacoes extends TransacaoEvent {}

class AdicionarTransacao extends TransacaoEvent {
  final Transacao transacao;

  const AdicionarTransacao(this.transacao);

  @override
  List<Object?> get props => [transacao];
}

class EditarTransacao extends TransacaoEvent {
  final Transacao transacao;

  const EditarTransacao(this.transacao);

  @override
  List<Object?> get props => [transacao];
}

class RemoverTransacao extends TransacaoEvent {
  final String id;

  const RemoverTransacao(this.id);

  @override
  List<Object?> get props => [id];
} 