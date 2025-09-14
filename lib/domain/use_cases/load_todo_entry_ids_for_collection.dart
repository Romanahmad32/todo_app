import 'package:dartz/dartz.dart';

import 'package:todo_app/domain/failures/failures.dart';

import '../../core/use_cases/use_case.dart';
import '../entities/unique_id.dart';
import '../repositories/todo_repository.dart';

class LoadToDoEntryIdsForCollection implements UseCase<List<EntryId>, LoadToDoEntryIdsParams>{

  final ToDoRepository toDoRepository;
  const LoadToDoEntryIdsForCollection({required this.toDoRepository});

  @override
  Future<Either<Failure, List<EntryId>>> call(LoadToDoEntryIdsParams params) async{
    try{
      final loadedEntryIds = await toDoRepository.readToDoEntryIds(params.collectionId);
      return loadedEntryIds.fold(
        (left) => Left(left),
        (right) => Right(right)
      );

    }on Exception catch(e){
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }

}
class LoadToDoEntryIdsParams {
  final CollectionId collectionId;
  const LoadToDoEntryIdsParams({required this.collectionId});
}