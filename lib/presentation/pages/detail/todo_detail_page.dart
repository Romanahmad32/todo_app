import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/core/page_config.dart';
import 'package:todo_app/presentation/pages/detail/view_states/todo_detail_error.dart';
import 'package:todo_app/presentation/pages/detail/view_states/todo_detail_loaded.dart';
import 'package:todo_app/presentation/pages/detail/view_states/todo_detail_loading.dart';

import '../../../domain/entities/unique_id.dart';
import '../../../domain/repositories/todo_repository.dart';
import '../../../domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'blocs/todo_detail_cubit.dart';

class ToDoDetailPageProvider extends StatelessWidget {
  final CollectionId collectionId;

  const ToDoDetailPageProvider({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoDetailCubit(
        collectionId: collectionId,
        loadToDoEntryIdsForCollection: LoadToDoEntryIdsForCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: ToDoDetailPage(collectionId: collectionId),
    );
  }
}

class ToDoDetailPage extends StatelessWidget {
  final CollectionId collectionId;

  const ToDoDetailPage({super.key, required this.collectionId});

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.details_rounded,
    name: 'detail',
    child: Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoDetailCubit, ToDoDetailCubitState>(
      builder: (context, state) {
        if (state is ToDoDetailCubitStateLoading) {
          return TodoDetailLoading();
        }
        if (state is ToDoDetailCubitStateLoaded) {
          return TodoDetailLoaded(
            collectionId: collectionId,
            entryIds: state.entryIds,
          );
        }
        return const TodoDetailError();
      },
    );
  }
}
