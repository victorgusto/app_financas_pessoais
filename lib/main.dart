import 'package:financas_pessoais/presentation/bloc/editar_transacao_bloc.dart';
import 'package:financas_pessoais/presentation/theme/dark_theme.dart';
import 'package:financas_pessoais/presentation/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:financas_pessoais/data/models/transacao_model.dart';
import 'package:financas_pessoais/data/datasources/transacao_local_datasource.dart';
import 'package:financas_pessoais/data/transacao_repository_imp.dart';
import 'package:financas_pessoais/domain/repositories/transacao_repository.dart';
import 'package:financas_pessoais/domain/usecases/transacao_usecase.dart';
import 'package:financas_pessoais/domain/usecases/transacao_usecase_impl.dart';
import 'package:financas_pessoais/presentation/bloc/transacao_bloc.dart';
import 'package:financas_pessoais/presentation/pages/pagina_inicial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TransacaoModelAdapter());
  await Hive.openBox<TransacaoModel>('transacoes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TransacaoLocalDataSource>(
          create: (context) => TransacaoLocalDatasource(),
        ),

        RepositoryProvider<TransacaoRepository>(
          create: (context) => TransacaoRepositoryImpl(
            transacaoLocalDataSource: context.read<TransacaoLocalDataSource>(),
          ),
        ),
        RepositoryProvider<TransacaoUseCase>(
          create: (context) => TransacaoUseCaseImpl(
            transacaoRepository: context.read<TransacaoRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Finanças Pessoais',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TransacaoBloc(
                transacaoUseCase: context.read<TransacaoUseCase>(),
              ),
            ),

            BlocProvider(
              create: (context) => EditarTransacaoBloc(
                useCase: context.read<TransacaoUseCase>(),
              ),
            ),
          ],
          child: const PaginaInicial(),
        ),
      ),
    );
  }
}
