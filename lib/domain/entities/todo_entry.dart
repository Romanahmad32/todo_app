import 'package:todo_app/domain/entities/unique_id.dart';

class ToDoEntry {
  final String description;
  final bool isDone;
  final EntryId id;

  const ToDoEntry({
    required this.description,
    required this.isDone,
    required this.id,
  });

  factory ToDoEntry.empty() {
    return ToDoEntry(
      id: EntryId(),
      description: '',
      isDone: false,
    );
  }

  ToDoEntry copyWith({
    String? description,
    bool? isDone,
    EntryId? id,
  }) {
    return ToDoEntry(
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
    );
  }
}
