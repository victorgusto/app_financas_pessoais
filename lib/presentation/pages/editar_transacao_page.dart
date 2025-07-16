import 'package:financas_pessoais/domain/entities/transacao.dart';
import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';
import 'package:financas_pessoais/presentation/bloc/editar_transacao_bloc.dart';
import 'package:financas_pessoais/presentation/bloc/editar_transacao_event.dart';
import 'package:financas_pessoais/presentation/bloc/editar_transacao_state.dart';
import 'package:financas_pessoais/presentation/utils/currency_input_formatter.dart';
import 'package:financas_pessoais/presentation/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditarTransacaoPage extends StatefulWidget {
  final Transacao transacao;
  final TransacaoUseCase useCase;

  const EditarTransacaoPage({
    super.key,
    required this.transacao,
    required this.useCase,
  });

  @override
  State<EditarTransacaoPage> createState() => _EditarTransacaoPageState();
}

class _EditarTransacaoPageState extends State<EditarTransacaoPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descricaoController;
  late final TextEditingController _valorController;
  late final TextEditingController _dataController;
  late TipoTransacao _tipoSelecionado;
  late DateTime _dataSelecionada;

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController(
      text: widget.transacao.descricao,
    );
    _valorController = TextEditingController(
      text: FormatterFunctions.formatarDoubleParaMoedaBRL(
        widget.transacao.valor,
      ),
    );
    _dataSelecionada = widget.transacao.data;
    _dataController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(_dataSelecionada),
    );
    _tipoSelecionado = widget.transacao.tipo;
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Transação'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: colorScheme.error),
            onPressed: () => _confirmarExclusao(context),
            tooltip: 'Excluir Transação',
          ),
        ],
      ),
      body: Builder(
        builder: (innerCotext) {
          return BlocConsumer<EditarTransacaoBloc, EditarTransacaoState>(
            listener: (context, state) {
              if (state is EditarTransacaoSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: colorScheme.primary,
                  ),
                );
                Navigator.pop(context, true);
              }

              if (state is ExcluirTransacaoSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: colorScheme.primary,
                  ),
                );
                Navigator.pop(context, true);
              }

              if (state is EditarTransacaoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: colorScheme.error,
                  ),
                );
              }

              if (state is ExcluirTransacaoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: colorScheme.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Tipo de Transação',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: SegmentedButton<TipoTransacao>(
                                    segments: [
                                      ButtonSegment(
                                        value: TipoTransacao.entrada,
                                        label: const Text('Entrada'),
                                        icon: Icon(
                                          Icons.arrow_upward,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                      ButtonSegment(
                                        value: TipoTransacao.saida,
                                        label: const Text('Saída'),
                                        icon: Icon(
                                          Icons.arrow_downward,
                                          color: colorScheme.error,
                                        ),
                                      ),
                                    ],
                                    selected: {_tipoSelecionado},
                                    onSelectionChanged:
                                        (Set<TipoTransacao> selection) {
                                          setState(() {
                                            _tipoSelecionado = selection.first;
                                          });
                                        },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _descricaoController,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            prefixIcon: Icon(Icons.description),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor, informe uma descrição';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _valorController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyInputFormatter(),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Valor',
                            prefixIcon: Icon(Icons.attach_money),
                            prefixText: 'R\$ ',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor, informe um valor';
                            }
                            if (value == '0,00') {
                              return 'Por favor, informe um valor válido maior que zero';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _dataController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Data',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: _selectDate,
                        ),

                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    state is EditarTransacaoSubmitting ||
                                        state is ExcluirTransacaoLoading
                                    ? null
                                    : _salvarEdicao,
                                child: state is EditarTransacaoSubmitting
                                    ? const CircularProgressIndicator()
                                    : const Text('Salvar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dataSelecionada = picked;
        _dataController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _salvarEdicao() {
    if (_formKey.currentState!.validate()) {
      final valorConvertido = FormatterFunctions.converterMoedaParaDouble(
        _valorController.text,
      );

      final transacaoEditada = Transacao(
        id: widget.transacao.id,
        descricao: _descricaoController.text.trim(),
        valor: valorConvertido,
        data: _dataSelecionada,
        tipo: _tipoSelecionado,
      );

      context.read<EditarTransacaoBloc>().add(
        EditarTransacaoSubmitted(transacaoEditada),
      );
    }
  }

  void _confirmarExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text(
            'Tem certeza que deseja excluir esta transação? Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<EditarTransacaoBloc>().add(
                  ExcluirTransacaoSubmitted(widget.transacao.id),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
