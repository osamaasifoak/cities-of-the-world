// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityAdapter extends TypeAdapter<CityModel> {
  @override
  final int typeId = 0;

  @override
  CityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityModel(
      id: fields[0] as int,
      name: fields[1] as String,
      localName: fields[2] as String,
      lat: fields[3] as double?,
      lng: fields[4] as double?,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      countryId: fields[7] as int,
      country: fields[8] as CountryModel,
    );
  }

  @override
  void write(BinaryWriter writer, CityModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.localName)
      ..writeByte(3)
      ..write(obj.lat)
      ..writeByte(4)
      ..write(obj.lng)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.countryId)
      ..writeByte(8)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityFromJson(Map<String, dynamic> json) => CityModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      localName: json['localName'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      countryId: (json['countryId'] as num).toInt(),
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CityToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'localName': instance.localName,
      'lat': instance.lat,
      'lng': instance.lng,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'countryId': instance.countryId,
      'country': instance.country,
    };
