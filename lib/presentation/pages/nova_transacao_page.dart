import 'package:financas_pessoais/domain/entities/transacao.dart';
import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';
import 'package:financas_pessoais/presentation/bloc/nova_transacao_bloc.dart';
import 'package:financas_pessoais/presentation/bloc/nova_transacao_event.dart';
import 'package:financas_pessoais/presentation/bloc/nova_transacao_state.dart';
import 'package:financas_pessoais/presentation/utils/currency_input_formatter.dart';
import 'package:financas_pessoais/presentation/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NovaTransacaoPage extends StatefulWidget {
  final TransacaoUseCase useCase;

  const NovaTransacaoPage({super.key, required this.useCase});

  @override
  State<NovaTransacaoPage> createState() => _NovaTransacaoPageState();
}

class _NovaTransacaoPageState extends State<NovaTransacaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  TipoTransacao _tipoSelecionado = TipoTransacao.entrada;
  DateTime _dataSelecionada = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dataController.text = DateFormat('dd/MM/yyyy').format(_dataSelecionada);
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
      appBar: AppBar(title: const Text('Nova Transação'), centerTitle: true),
      body: BlocConsumer<NovaTransacaoBloc, NovaTransacaoState>(
        listener: (context, state) {
          if (state is NovaTransacaoSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.primary,
              ),
            );
            Navigator.pop(context, true);
          }

          if (state is NovaTransacaoError) {
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Tipo de Transação ',
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
                                      ButtonSegment<TipoTransacao>(
                                        value: TipoTransacao.entrada,
                                        label: const Text('Entrada'),
                                        icon: Icon(
                                          Icons.arrow_upward,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                      ButtonSegment<TipoTransacao>(
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
                                        (Set<TipoTransacao> newSelection) {
                                          setState(() {
                                            _tipoSelecionado =
                                                newSelection.first;
                                          });
                                        },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descricaoController,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        prefixIcon: Icon(Icons.description),
                        errorText: state is NovaTransacaoInvalid
                            ? state.errors['descricao']
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Descrição é obrigatória';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _valorController,
                      decoration: InputDecoration(
                        labelText: 'Valor',
                        prefix: Text('R\$'),
                        prefixIcon: Icon(Icons.attach_money),
                        errorText: state is NovaTransacaoInvalid
                            ? state.errors['valor']
                            : null,
                      ),
                      keyboardType: TextInputType.number,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Valor é obrigatório';
                        }
                        if (value == '0,00') {
                          return 'Valor não pode ser 0,00';
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

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: state is NovaTransacaoSubmitting
                            ? null
                            : _salvarTransacao,
                        child: state is NovaTransacaoSubmitting
                            ? const CircularProgressIndicator()
                            : const Text('Salvar Transação'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

  void _salvarTransacao() {
    if (_formKey.currentState!.validate()) {
      final valorConvertido = FormatterFunctions.converterMoedaParaDouble(
        _valorController.text,
      );

      final transacao = Transacao(
        id: '',
        descricao: _descricaoController.text.trim(),
        valor: valorConvertido,
        data: _dataSelecionada,
        tipo: _tipoSelecionado,
      );

      context.read<NovaTransacaoBloc>().add(NovaTransacaoSubmitted(transacao));
    }
  }
}
