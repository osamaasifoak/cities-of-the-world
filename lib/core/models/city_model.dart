import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'country_model.dart';

part 'city_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CityModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  @JsonKey(name: 'local_name')
  final String localName;

  @HiveField(3)
  final double? lat;

  @HiveField(4)
  final double? lng;

  @HiveField(5)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @HiveField(6)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @HiveField(7)
  @JsonKey(name: 'country_id')
  final int countryId;

  @HiveField(8)
  final CountryModel country;

  CityModel({
    required this.id,
    required this.name,
    required this.localName,
    this.lat,
    this.lng,
    required this.createdAt,
    required this.updatedAt,
    required this.countryId,
    required this.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
