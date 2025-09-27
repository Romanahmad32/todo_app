import 'package:hive/hive.dart';
import 'package:todo_app/data/exeptions/exeptions.dart';
import 'package:todo_app/data/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/data/models/todo_collection_model.dart';
import 'package:todo_app/data/models/todo_entry_model.dart';

class HiveLocalDataSource implements ToDoLocalDataSourceInterface {
  late BoxCollection todoCollections;

  bool isInitialized = false;

  Future<void> initialize() async {
    if (!isInitialized) {
      todoCollections = await BoxCollection.open(
        'todo',
        {'collection', 'entry'},
        path: './',
      );
      isInitialized = true;
    } else {
      print('HiveLocalDataSource already initialized');
    }
  }

  Future<CollectionBox<Map>> _openCollectionBox() async {
    return todoCollections.openBox<Map>('collection');
  }

  Future<CollectionBox<Map>> _openEntryBox() async {
    return todoCollections.openBox<Map>('entry');
  }

  @override
  Future<bool> createToDoCollection(
      {required ToDoCollectionModel collection}) async {
    try {
      final collectionBox = await _openCollectionBox();
      final entryBox = await _openEntryBox();
      await collectionBox.put(collection.id, collection.toJson());
      await entryBox.put(collection.id, {});
      return true;
    } on Exception catch (_) {
      throw HiveCacheException();
    }
  }

  @override
  Future<bool> createToDoEntry(
      {required String collectionId, required ToDoEntryModel entry}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) throw CollectionNotFoundException();
      entryList.cast<String, dynamic>().putIfAbsent(
            entry.id,
            () => entry.toJson(),
          );
      await entryBox.put(collectionId, entryList);
      return true;
    } on Exception catch (_) {
      throw HiveCacheException();
    }
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) async {
    try {
      final collectionBox = await _openCollectionBox();
      final collection =
          (await collectionBox.get(collectionId))?.cast<String, dynamic>();
      if (collection == null) throw EntryNotFoundException();

      return ToDoCollectionModel.fromJson(collection);
    } on Exception catch (_) {
      throw HiveCacheException();
    }
  }

  @override
  Future<List<String>> getToDoCollectionIds() async {
    try {
      final collectionBox = await _openCollectionBox();
      return await collectionBox.getAllKeys();
    } on Exception catch (_) {
      throw HiveCacheException();
    }
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required String collectionId, required String entryId}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) throw CollectionNotFoundException();

      if (!entryList.containsKey(entryId)) throw EntryNotFoundException();
      final entry = entryList[entryId].cast<String, dynamic>();
      return ToDoEntryModel.fromJson(entry);
    } on Exception catch (_) {
      throw HiveCacheException();
    }
  }

  @override
  Future<List<String>> getToDoEntryIds({required String collectionId}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) throw CollectionNotFoundException();

      final entryIdList = entryList.cast<String, dynamic>().keys.toList();
      return entryIdList;
    } on Exception catch (_) {
      throw HiveCacheException();
    }
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) throw CollectionNotFoundException();
      if(!entryList.containsKey(entryId)) throw EntryNotFoundException();
      final entry = ToDoEntryModel.fromJson(entryList[entryId].cast<String, dynamic>());
      final updatedEntry = ToDoEntryModel(id: entry.id, description: entry.description, isDone: !entry.isDone);
      entryList[entryId] = updatedEntry.toJson();
      await entryBox.put(collectionId, entryList);
      return updatedEntry;
    } on Exception catch (_) {
      throw HiveCacheException();
    }
  }
}
