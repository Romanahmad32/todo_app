import 'package:flutter/material.dart';

class ToDoEntryItemError extends StatelessWidget {
  const ToDoEntryItemError({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => (),
      leading: Icon(Icons.warning_rounded),
      title: Text('Could not lead item'),
    );
  }
}
