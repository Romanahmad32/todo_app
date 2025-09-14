import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';

import '../../core/use_cases/use_case.dart';
import '../entities/todo_entry.dart';
import '../repositories/todo_repository.dart';

class UpdateToDoEntry implements UseCase<ToDoEntry, UpdateToDoEntryParams> {
  final ToDoRepository toDoRepository;

  const UpdateToDoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, ToDoEntry>> call(UpdateToDoEntryParams params) async {
    try {
      final updatedEntry = await toDoRepository.updateToDoEntry(
          params.collectionId, params.entryId);

      return updatedEntry.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}

class UpdateToDoEntryParams {
  final EntryId entryId;
  final CollectionId collectionId;

  UpdateToDoEntryParams({required this.entryId, required this.collectionId});
}
