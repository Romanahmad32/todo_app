part of 'todo_overview_cubit.dart';

abstract class ToDoOverviewCubitState extends Equatable {
  const ToDoOverviewCubitState();

  @override
  List<Object?> get props => [];
}

class ToDoOverviewCubitLoadingState extends ToDoOverviewCubitState {}

class ToDoOverviewCubitLoadedState extends ToDoOverviewCubitState {
  final List<ToDoCollection> collections;

  const ToDoOverviewCubitLoadedState({required this.collections});

  @override
  List<Object?> get props => [collections];
}

class ToDoOverviewCubitErrorState extends ToDoOverviewCubitState {}
