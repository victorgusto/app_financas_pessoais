import 'package:hive_flutter/hive_flutter.dart';
import 'package:financas_pessoais/data/models/transacao_model.dart';

abstract class TransacaoLocalDataSource {
  Future<List<TransacaoModel>> obterTodas();
  Future<void> adicionar(TransacaoModel transacao);
  Future<void> editar(TransacaoModel transacao);
  Future<void> remover(String id);
}

class TransacaoLocalDatasource implements TransacaoLocalDataSource {
  static const String _boxName = 'transacoes';

  Box<TransacaoModel> get _box => Hive.box<TransacaoModel>(_boxName);

  @override
  Future<List<TransacaoModel>> obterTodas() async {
    try {
      final transacoes = _box.values.toList();
      return transacoes;
    } catch (e) {
      throw Exception('Erro ao obter transações: ${e.toString()}');
    }
  }

  @override
  Future<void> adicionar(TransacaoModel transacao) async {
    try {
      await _box.add(transacao);
    } catch (e) {
      throw Exception('Erro ao adicionar transação: ${e.toString()}');
    }
  }

  @override
  Future<void> editar(TransacaoModel transacao) async {
    try {
      final transacoes = _box.values.toList();
      final index = transacoes.indexWhere((t) => t.id == transacao.id);

      if (index != -1) {
        await _box.putAt(index, transacao);
      } else {
        throw Exception('Transação não encontrada para edição');
      }
    } catch (e) {
      throw Exception('Erro ao editar transação: ${e.toString()}');
    }
  }

  @override
  Future<void> remover(String id) async {
    try {
      final transacoes = _box.values.toList();
      final index = transacoes.indexWhere((t) => t.id == id);

      if (index != -1) {
        await _box.deleteAt(index);
      } else {
        throw Exception('Transação não encontrada para remoção');
      }
    } catch (e) {
      throw Exception('Erro ao remover transação: ${e.toString()}');
    }
  }
} 