import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CountryModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String code;

  @HiveField(3)
  @JsonKey(name: 'continent_id')
  final int continentId;

  CountryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.continentId,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
