import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';
import 'package:financas_pessoais/presentation/bloc/nova_transacao_event.dart';
import 'package:financas_pessoais/presentation/bloc/nova_transacao_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NovaTransacaoBloc
    extends Bloc<NovaTransacaoEvent, NovaTransacaoState> {
  final TransacaoUseCase useCase;

  NovaTransacaoBloc({required this.useCase})
      : super(NovaTransacaoInitial()) {
    on<NovaTransacaoSubmitted>(_onSubmitted);
  }

  void _onSubmitted(
    NovaTransacaoSubmitted event,
    Emitter<NovaTransacaoState> emit,
  ) async {
    emit(NovaTransacaoSubmitting());
    try {
      await useCase.adicionar(event.transacao);
      emit(NovaTransacaoSuccess('Transação adicionada com sucesso!'));
    } catch (e) {
      emit(NovaTransacaoError('Erro ao adicionar transação: ${e.toString()}'));
    }
  }
}
