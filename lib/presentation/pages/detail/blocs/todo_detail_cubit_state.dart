part of 'todo_detail_cubit.dart';

abstract class ToDoDetailCubitState extends Equatable {
  const ToDoDetailCubitState();

  @override
  List<Object?> get props => [];
}

class ToDoDetailCubitStateLoading extends ToDoDetailCubitState {}

class ToDoDetailCubitStateLoaded extends ToDoDetailCubitState {
  final List<EntryId> entryIds;

  const ToDoDetailCubitStateLoaded({required this.entryIds});

  @override
  List<Object?> get props => [entryIds];
}

class ToDoDetailCubitStateError extends ToDoDetailCubitState {}
