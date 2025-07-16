import 'package:financas_pessoais/domain/entities/transacao.dart';
import 'package:financas_pessoais/domain/repositories/transacao_repository.dart';
import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';
import 'package:uuid/uuid.dart';

class TransacaoUseCaseImpl implements TransacaoUseCase {
  final TransacaoRepository _transacaoRepository;
  final Uuid _uuid = Uuid();

  TransacaoUseCaseImpl({required TransacaoRepository transacaoRepository})
    : _transacaoRepository = transacaoRepository;

  @override
  Future<List<Transacao>> obterTodas() async {
    try {
      final transacoes = await _transacaoRepository.obterTodas();

      transacoes.sort((a, b) => b.data.compareTo(a.data));

      return transacoes;
    } catch (e) {
      throw Exception('Erro ao obter transações: ${e.toString()}');
    }
  }

  @override
  Future<void> adicionar(Transacao transacao) async {
    try {
      _validarTransacao(transacao);

      final novaTransacao = transacao.copyWith(id: _uuid.v4());
      await _transacaoRepository.adicionar(novaTransacao);
    } catch (e) {
      throw Exception('Erro ao adicionar transação: ${e.toString()}');
    }
  }

  @override
  Future<void> editar(Transacao transacao) async {
    try {
      _validarTransacao(transacao);
      await _transacaoRepository.editar(transacao);
    } catch (e) {
      throw Exception('Erro ao editar transação: ${e.toString()}');
    }
  }

  @override
  Future<void> remover(String id) async {
    try {
      _validarId(id);
      await _transacaoRepository.remover(id);
    } catch (e) {
      throw Exception('Erro ao remover transação: ${e.toString()}');
    }
  }

  @override
  Future<double> calcularSaldoTotal() async {
    try {
      final transacoes = await _transacaoRepository.obterTodas();

      return transacoes.fold<double>(0.0, (sum, transacao) {
        if (transacao.tipo == TipoTransacao.entrada) {
          return sum + transacao.valor;
        } else {
          return sum - transacao.valor;
        }
      });
    } catch (e) {
      throw Exception('Erro ao calcular saldo total: ${e.toString()}');
    }
  }

  @override
  Future<double> calcularTotalEntradas() async {
    try {
      final transacoes = await _transacaoRepository.obterTodas();
      return transacoes
          .where((transacao) => transacao.tipo == TipoTransacao.entrada)
          .fold<double>(0.0, (sum, transacao) => sum + transacao.valor);
    } catch (e) {
      throw Exception('Erro ao calcular total de entradas: ${e.toString()}');
    }
  }

  @override
  Future<double> calcularTotalSaidas() async {
    try {
      final transacoes = await _transacaoRepository.obterTodas();
      return transacoes
          .where((transacao) => transacao.tipo == TipoTransacao.saida)
          .fold<double>(0.0, (sum, transacao) => sum + transacao.valor);
    } catch (e) {
      throw Exception('Erro ao calcular total de saídas: ${e.toString()}');
    }
  }

  void _validarId(String id) {
    if (id.isEmpty) {
      throw Exception('O ID da transação não pode ser vazio');
    }
  }

  void _validarTransacao(Transacao transacao) {
    if (transacao.descricao.isEmpty) {
      throw Exception('A descrição da transação não pode ser vazia');
    }

    if (transacao.valor == 0) {
      throw Exception('O valor da transação não pode ser 0');
    }

    if (transacao.data.isAfter(DateTime.now())) {
      throw Exception('A data da transação não pode ser futura');
    }

    if (transacao.tipo != TipoTransacao.entrada &&
        transacao.tipo != TipoTransacao.saida) {
      throw Exception('O tipo da transação deve ser "entrada" ou "saida"');
    }
  }
}
