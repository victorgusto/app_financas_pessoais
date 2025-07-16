import 'package:equatable/equatable.dart';
import 'package:financas_pessoais/domain/entities/transacao.dart';

abstract class EditarTransacaoState extends Equatable {
  const EditarTransacaoState();

  @override
  List<Object?> get props => [];
}

class EditarTransacaoInitial extends EditarTransacaoState {}

class EditarTransacaoLoading extends EditarTransacaoState {}

class EditarTransacaoCarregada extends EditarTransacaoState {
  final Transacao transacao;

  const EditarTransacaoCarregada(this.transacao);

  @override
  List<Object?> get props => [transacao];
}

class EditarTransacaoSubmitting extends EditarTransacaoState {}

class EditarTransacaoSuccess extends EditarTransacaoState {
  final String message;

  const EditarTransacaoSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EditarTransacaoError extends EditarTransacaoState {
  final String error;

  const EditarTransacaoError(this.error);

  @override
  List<Object?> get props => [error];
}

class ExcluirTransacaoLoading extends EditarTransacaoState {}

class ExcluirTransacaoSuccess extends EditarTransacaoState {
  final String message;

  const ExcluirTransacaoSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ExcluirTransacaoError extends EditarTransacaoState {
  final String error;

  const ExcluirTransacaoError(this.error);

  @override
  List<Object?> get props => [error];
}
