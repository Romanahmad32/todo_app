import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/presentation/pages/detail/todo_detail_page.dart';

import '../../create_todo_collection/create_todo_collection_page.dart';
import '../../home/blocs/navigation_todo_cubit.dart';

class TodoOverviewLoaded extends StatelessWidget {
  final List<ToDoCollection> collections;

  const TodoOverviewLoaded({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    final shouldDisplayAddItemButton = Breakpoints.small.isActive(context);
    return BlocBuilder<NavigationToDoCubit, NavigationToDoCubitState>(
      buildWhen: (previous, current) =>
          previous.selectedCollectionId != current.selectedCollectionId,
      builder: (context, state) {
        return Stack(
          children: [
            ListView.builder(
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final item = collections[index];
                final colorScheme = Theme.of(context).colorScheme;
                return ListTile(
                  tileColor: colorScheme.surface,
                  iconColor: item.color.color,
                  title: Text(item.title),
                  selected: state.selectedCollectionId == item.id,
                  selectedColor: item.color.color,
                  onTap: () {
                    context
                        .read<NavigationToDoCubit>()
                        .selectedToDoCollectionChanged(
                          item.id,
                        );
                    if (Breakpoints.small.isActive(context)) {
                      context.pushNamed(
                        ToDoDetailPage.pageConfig.name,
                        pathParameters: {
                          'collectionId': item.id.value,
                        },
                      );
                    }
                  },
                  leading: const Icon(Icons.circle),
                );
              },
            ),
         if(shouldDisplayAddItemButton)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    key: Key('create-todo-collection'),
                    heroTag: 'create-todo-collection',
                    onPressed: () => context
                        .pushNamed(CreateTodoCollectionPage.pageConfig.name),
                    child: Icon(
                      CreateTodoCollectionPage.pageConfig.icon,
                    ),
                  ),
                ),
              )

          ],
        );
      },
    );
  }
}
