import 'package:equatable/equatable.dart';
import 'package:financas_pessoais/domain/entities/transacao.dart';

abstract class TransacaoState extends Equatable {
  const TransacaoState();

  @override
  List<Object?> get props => [];
}

class TransacaoInitial extends TransacaoState {}

class TransacaoLoading extends TransacaoState {}

class TransacaoLoaded extends TransacaoState {
  final List<Transacao> transacoes;
  final double saldoTotal;
  final double totalEntradas;
  final double totalSaidas;

  const TransacaoLoaded({
    required this.transacoes,
    required this.saldoTotal,
    required this.totalEntradas,
    required this.totalSaidas,
  });

  TransacaoLoaded copyWith({
    List<Transacao>? transacoes,
    double? saldoTotal,
    double? totalEntradas,
    double? totalSaidas,
  }) {
    return TransacaoLoaded(
      transacoes: transacoes ?? this.transacoes,
      saldoTotal: saldoTotal ?? this.saldoTotal,
      totalEntradas: totalEntradas ?? this.totalEntradas,
      totalSaidas: totalSaidas ?? this.totalSaidas,
    );
  }

  @override
  List<Object?> get props => [
        transacoes,
        saldoTotal,
        totalEntradas,
        totalSaidas,
      ];
}

class TransacaoError extends TransacaoState {
  final String message;

  const TransacaoError({required this.message});

  @override
  List<Object?> get props => [message];
} 