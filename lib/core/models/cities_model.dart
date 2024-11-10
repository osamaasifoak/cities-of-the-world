import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'city_model.dart';
import 'pagination_model.dart';

part 'cities_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class CitiesModel {
  @HiveField(0)
  final List<CityModel> items;

  @HiveField(1)
  final PaginationModel pagination;

  CitiesModel({
    required this.items,
    required this.pagination,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) =>
      _$CitiesModelFromJson(json);
  Map<String, dynamic> toJson() => _$CitiesModelToJson(this);
}
