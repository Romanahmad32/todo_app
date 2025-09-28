import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/data/local/hive_local_data_source.dart';
import 'package:todo_app/data/repositories/todo_repository_local.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/presentation/app/cubit/auth_cubit.dart';

import 'core/router/routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authCubit = AuthCubit();
  final authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
    authCubit.authStateChanged(user: user);
  },);
  final localDatasource = HiveLocalDataSource();
  await localDatasource.initialize();
  runApp(
    RepositoryProvider<ToDoRepository>(
      create: (context) =>
          ToDoRepositoryLocal(localDataSource: localDatasource),
      child: BlocProvider<AuthCubit>(
        create: (context) => authCubit,
        child: const ToDoApp(),
      ),
    ),
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
      title: 'ToDo App',
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
