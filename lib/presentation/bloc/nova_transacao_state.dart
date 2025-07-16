import 'package:equatable/equatable.dart';

abstract class NovaTransacaoState extends Equatable {
  const NovaTransacaoState();

  @override
  List<Object?> get props => [];
}

class NovaTransacaoInitial extends NovaTransacaoState {}

class NovaTransacaoSubmitting extends NovaTransacaoState {}

class NovaTransacaoSuccess extends NovaTransacaoState {
  final String message;

  const NovaTransacaoSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class NovaTransacaoError extends NovaTransacaoState {
  final String error;

  const NovaTransacaoError(this.error);

  @override
  List<Object> get props => [error];
}

class NovaTransacaoInvalid extends NovaTransacaoState {
  final Map<String, String> errors;

  const NovaTransacaoInvalid(this.errors);

  @override
  List<Object> get props => [errors];
} 