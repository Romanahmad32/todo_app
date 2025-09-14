import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/presentation/pages/detail/todo_detail_page.dart';

class TodoOverviewLoaded extends StatelessWidget {
  final List<ToDoCollection> collections;

  const TodoOverviewLoaded({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    ;
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final item = collections[index];
        final colorScheme = Theme.of(context).colorScheme;
        return ListTile(
          tileColor: colorScheme.surface,
          iconColor: item.color.color,
          title: Text(item.title),
          subtitle: Text(item.id.value),
          selectedColor: item.color.color,
          onTap: () {
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
    );
  }
}
