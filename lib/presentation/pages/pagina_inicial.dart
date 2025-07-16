import 'package:financas_pessoais/domain/entities/transacao.dart';
import 'package:financas_pessoais/presentation/bloc/editar_transacao_bloc.dart';
import 'package:financas_pessoais/presentation/bloc/nova_transacao_bloc.dart';
import 'package:financas_pessoais/presentation/bloc/transacao_bloc.dart';
import 'package:financas_pessoais/presentation/bloc/transacao_event.dart';
import 'package:financas_pessoais/presentation/bloc/transacao_state.dart';
import 'package:financas_pessoais/presentation/pages/nova_transacao_page.dart';
import 'package:financas_pessoais/presentation/pages/editar_transacao_page.dart';
import 'package:financas_pessoais/presentation/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  @override
  void initState() {
    super.initState();
    context.read<TransacaoBloc>().add(CarregarTransacoes());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Finanças Pessoais'), centerTitle: true),
      body: BlocBuilder<TransacaoBloc, TransacaoState>(
        builder: (context, state) {
          if (state is TransacaoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransacaoLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildResumoCard(
                          'Saldo Total',
                          'R\$${FormatterFunctions.formatarDoubleParaMoedaBRL(state.saldoTotal)}',
                          state.saldoTotal >= 0
                              ? colorScheme.primary
                              : colorScheme.error,
                          Icons.account_balance_wallet,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildResumoCard(
                          'Entradas',
                          'R\$${FormatterFunctions.formatarDoubleParaMoedaBRL(state.totalEntradas)}',
                          colorScheme.primary,
                          Icons.arrow_upward,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildResumoCard(
                          'Saídas',
                          'R\$${FormatterFunctions.formatarDoubleParaMoedaBRL(state.totalSaidas)}',
                          colorScheme.error,
                          Icons.arrow_downward,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: state.transacoes.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 64,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Nenhuma transação encontrada',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Toque no botão + para adicionar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.transacoes.length,
                            itemBuilder: (context, index) {
                              final transacao = state.transacoes[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: Icon(
                                    transacao.tipo == TipoTransacao.entrada
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color:
                                        transacao.tipo == TipoTransacao.entrada
                                        ? colorScheme.primary
                                        : colorScheme.error,
                                  ),
                                  title: Text(
                                    transacao.descricao,
                                    style: TextStyle(
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${transacao.data.day}/${transacao.data.month}/${transacao.data.year}',
                                    style: TextStyle(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.7),
                                    ),
                                  ),
                                  trailing: Text(
                                    'R\$${FormatterFunctions.formatarDoubleParaMoedaBRL(transacao.valor)}',
                                    style: TextStyle(
                                      color:
                                          transacao.tipo ==
                                              TipoTransacao.entrada
                                          ? colorScheme.primary
                                          : colorScheme.error,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () => _editarTransacao(transacao),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }

          if (state is TransacaoError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar transações',
                    style: TextStyle(fontSize: 16, color: colorScheme.error),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TransacaoBloc>().add(CarregarTransacoes());
                    },
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text(
              'Estado desconhecido',
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarNovaTransacao,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildResumoCard(
    String titulo,
    String valor,
    Color cor,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: cor, size: 20),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              valor,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _adicionarNovaTransacao() async {
    try {
      final useCase = context.read<TransacaoUseCase>();

      if (!mounted) return;

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                NovaTransacaoBloc(useCase: context.read<TransacaoUseCase>()),
            child: NovaTransacaoPage(useCase: useCase),
          ),
        ),
      );

      if (result == true && mounted) {
        context.read<TransacaoBloc>().add(CarregarTransacoes());
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao abrir nova transação: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _editarTransacao(Transacao transacao) async {
    try {
      final useCase = context.read<TransacaoUseCase>();

      if (!mounted) return;

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => EditarTransacaoBloc(useCase: useCase),
            child: EditarTransacaoPage(
              transacao: transacao,
              useCase: context.read<TransacaoUseCase>(),
            ),
          ),
        ),
      );

      if (result == true && mounted) {
        context.read<TransacaoBloc>().add(CarregarTransacoes());
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao abrir edição de transação: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
