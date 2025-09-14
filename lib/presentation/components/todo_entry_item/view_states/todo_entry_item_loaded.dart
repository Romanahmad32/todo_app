import 'package:flutter/material.dart';

import '../../../../domain/entities/todo_entry.dart';

class ToDoEntryItemLoaded extends StatelessWidget {
  final ToDoEntry entry;
  final Function(bool?)? onChanged;

  const ToDoEntryItemLoaded({
    super.key,
    required this.entry,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: entry.isDone,
      onChanged: onChanged,
      title: Text(entry.description),
    );
  }
}
