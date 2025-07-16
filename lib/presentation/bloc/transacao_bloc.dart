import 'package:financas_pessoais/domain/entities/transacao.dart';
import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';
import 'package:financas_pessoais/presentation/bloc/transacao_event.dart';
import 'package:financas_pessoais/presentation/bloc/transacao_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransacaoBloc extends Bloc<TransacaoEvent, TransacaoState> {
  final TransacaoUseCase _transacaoUseCase;

  TransacaoBloc({required TransacaoUseCase transacaoUseCase})
      : _transacaoUseCase = transacaoUseCase,
        super(TransacaoInitial()) {
    on<CarregarTransacoes>(_onCarregarTransacoes);
    on<AdicionarTransacao>(_onAdicionarTransacao);
    on<EditarTransacao>(_onEditarTransacao);
    on<RemoverTransacao>(_onRemoverTransacao);
  }

  void _onCarregarTransacoes(
    CarregarTransacoes event,
    Emitter<TransacaoState> emit,
  ) async {
    emit(TransacaoLoading());
    try {
      final transacoes = await _transacaoUseCase.obterTodas();
      
      double saldoTotal = 0;
      double totalEntradas = 0;
      double totalSaidas = 0;

      for (var transacao in transacoes) {
        if (transacao.tipo == TipoTransacao.entrada) {
          saldoTotal += transacao.valor;
          totalEntradas += transacao.valor;
        } else {
          saldoTotal -= transacao.valor;
          totalSaidas += transacao.valor;
        }
      }

      emit(TransacaoLoaded(
        transacoes: transacoes,
        saldoTotal: saldoTotal,
        totalEntradas: totalEntradas,
        totalSaidas: totalSaidas,
      ));
    } catch (e) {
      emit(TransacaoError(message: 'Erro ao carregar transações: ${e.toString()}'));
    }
  }

  void _onAdicionarTransacao(
    AdicionarTransacao event,
    Emitter<TransacaoState> emit,
  ) async {
    try {
      await _transacaoUseCase.adicionar(event.transacao);
      add(CarregarTransacoes());
    } catch (e) {
      emit(TransacaoError(message: 'Erro ao adicionar transação: ${e.toString()}'));
    }
  }

  void _onEditarTransacao(
    EditarTransacao event,
    Emitter<TransacaoState> emit,
  ) async {
    try {
      await _transacaoUseCase.editar(event.transacao);
      add(CarregarTransacoes());
    } catch (e) {
      emit(TransacaoError(message: 'Erro ao editar transação: ${e.toString()}'));
    }
  }

  void _onRemoverTransacao(
    RemoverTransacao event,
    Emitter<TransacaoState> emit,
  ) async {
    try {
      await _transacaoUseCase.remover(event.id);
      add(CarregarTransacoes());
    } catch (e) {
      emit(TransacaoError(message: 'Erro ao remover transação: ${e.toString()}'));
    }
  }
}
