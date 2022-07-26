// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadistsR_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadistsRModel _$HadistsRModelFromJson(Map<String, dynamic> json) =>
    HadistsRModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataRandomHadists.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HadistsRModelToJson(HadistsRModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

DataRandomHadists _$DataRandomHadistsFromJson(Map<String, dynamic> json) =>
    DataRandomHadists(
      name: json['name'] as String,
      id: json['id'] as String,
      available: json['available'] as int,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => ContentsR.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataRandomHadistsToJson(DataRandomHadists instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'available': instance.available,
      'contents': instance.contents,
    };

ContentsR _$ContentsRFromJson(Map<String, dynamic> json) => ContentsR(
      number: json['number'] as int,
      arab: json['arab'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$ContentsRToJson(ContentsR instance) => <String, dynamic>{
      'number': instance.number,
      'arab': instance.arab,
      'id': instance.id,
    };
