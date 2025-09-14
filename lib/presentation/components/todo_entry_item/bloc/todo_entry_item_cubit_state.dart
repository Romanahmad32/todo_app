part of 'todo_entry_item_cubit.dart';

abstract class ToDoEntryItemState extends Equatable {
  const ToDoEntryItemState();

  @override
  List<Object?> get props => [];
}

class ToDoEntryItemLoadingState extends ToDoEntryItemState {}

class ToDoEntryItemLoadedState extends ToDoEntryItemState {
  final ToDoEntry entry;

  const ToDoEntryItemLoadedState({required this.entry});

  @override
  List<Object?> get props => [entry];
}

class ToDoEntryItemErrorState extends ToDoEntryItemState {}
