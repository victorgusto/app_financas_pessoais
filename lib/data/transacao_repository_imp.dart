import 'package:financas_pessoais/domain/entities/transacao.dart';
import 'package:financas_pessoais/domain/repositories/transacao_repository.dart';
import 'package:financas_pessoais/data/datasources/transacao_local_datasource.dart';
import 'package:financas_pessoais/data/models/transacao_model.dart';

class TransacaoRepositoryImpl implements TransacaoRepository {
  final TransacaoLocalDataSource _transacaoLocalDataSource;

  TransacaoRepositoryImpl({
    required TransacaoLocalDataSource transacaoLocalDataSource,
  }) : _transacaoLocalDataSource = transacaoLocalDataSource;

  @override
  Future<List<Transacao>> obterTodas() async {
    try {
      final transacaoModels = await _transacaoLocalDataSource.obterTodas();
      return transacaoModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Erro ao obter transações: ${e.toString()}');
    }
  }

  @override
  Future<void> adicionar(Transacao transacao) async {
    try {
      final transacaoModels = TransacaoModel.fromEntity(transacao);
      await _transacaoLocalDataSource.adicionar(transacaoModels);
    } catch (e) {
      throw Exception('Erro ao adicionar transação: ${e.toString()}');
    }
  }

  @override
  Future<void> editar(Transacao transacao) async {
    try {
      final transacaoModels = TransacaoModel.fromEntity(transacao);
      await _transacaoLocalDataSource.editar(transacaoModels);
    } catch (e) {
      throw Exception('Erro ao editar transação: ${e.toString()}');
    }
  }

  @override
  Future<void> remover(String id) async {
    try {
      await _transacaoLocalDataSource.remover(id);
    } catch (e) {
      throw Exception('Erro ao remover transação: ${e.toString()}');
    }
  }
}
