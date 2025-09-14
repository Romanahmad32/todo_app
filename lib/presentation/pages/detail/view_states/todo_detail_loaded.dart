import 'package:flutter/material.dart';

import '../../../../domain/entities/unique_id.dart';

class TodoDetailLoaded extends StatelessWidget {
  final List<EntryId> entryIds;
  final CollectionId collectionId;

  const TodoDetailLoaded({
    super.key,
    required this.entryIds,
    required this.collectionId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: entryIds.length,
            itemBuilder: (context, index) => Text('$index')),
      ),
    );
  }
}
