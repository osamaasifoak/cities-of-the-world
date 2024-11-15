import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class PaginationModel {
  @HiveField(0)
  @JsonKey(name: 'current_page')
  final int currentPage;

  @HiveField(1)
  @JsonKey(name: 'last_page')
  final int lastPage;

  @HiveField(2)
  @JsonKey(name: 'per_page')
  final int perPage;

  @HiveField(3)
  final int total;

  PaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
