import 'package:financas_pessoais/domain/entities/transacao.dart';

abstract class TransacaoRepository {
  Future<List<Transacao>> obterTodas();
  Future<void> adicionar(Transacao transacao);
  Future<void> editar(Transacao transacao);
  Future<void> remover(String id);
} 