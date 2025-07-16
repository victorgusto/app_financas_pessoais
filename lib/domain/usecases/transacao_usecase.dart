import 'package:financas_pessoais/domain/entities/transacao.dart';

abstract class TransacaoUseCase {
  Future<List<Transacao>> obterTodas();
  Future<void> adicionar(Transacao transacao);
  Future<void> editar(Transacao transacao);
  Future<void> remover(String id);
  Future<double> calcularSaldoTotal();
  Future<double> calcularTotalEntradas();
  Future<double> calcularTotalSaidas();
}
