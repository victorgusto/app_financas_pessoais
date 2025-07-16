import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';
import 'package:financas_pessoais/presentation/bloc/editar_transacao_event.dart';
import 'package:financas_pessoais/presentation/bloc/editar_transacao_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditarTransacaoBloc
    extends Bloc<EditarTransacaoEvent, EditarTransacaoState> {
  final TransacaoUseCase useCase;

  EditarTransacaoBloc({required this.useCase})
      : super(EditarTransacaoInitial()) {
    on<EditarTransacaoSubmitted>(_onSubmitted);
    on<ExcluirTransacaoSubmitted>(_onExcluirSubmitted);
  }

  void _onSubmitted(
    EditarTransacaoSubmitted event,
    Emitter<EditarTransacaoState> emit,
  ) async {
    emit(EditarTransacaoSubmitting());
    try {
      await useCase.editar(event.transacao);
      emit(EditarTransacaoSuccess('Transação editada com sucesso!'));
    } catch (e) {
      emit(EditarTransacaoError('Erro ao editar transação: ${e.toString()}'));
    }
  }

  void _onExcluirSubmitted(
    ExcluirTransacaoSubmitted event,
    Emitter<EditarTransacaoState> emit,
  ) async {
    emit(ExcluirTransacaoLoading());
    try {
      await useCase.remover(event.transacaoId);
      emit(ExcluirTransacaoSuccess('Transação excluída com sucesso!'));
    } catch (e) {
      emit(ExcluirTransacaoError('Erro ao excluir transação: ${e.toString()}'));
    }
  }
}
