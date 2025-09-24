import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_collection_model.g.dart';

@JsonSerializable()
class ToDoCollectionModel extends Equatable {
  final String id;
  final int colorIndex;
  final String title;

  const ToDoCollectionModel({
    required this.id,
    required this.colorIndex,
    required this.title,
  });

  factory ToDoCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$ToDoCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoCollectionModelToJson(this);

  @override
  List<Object?> get props => [colorIndex, title, id];
}
