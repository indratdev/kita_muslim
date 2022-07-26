import 'package:json_annotation/json_annotation.dart';

part 'hadistsR_model.g.dart';

@JsonSerializable()
class HadistsRModel {
  int code;
  String message;
  List<DataRandomHadists> data;

  HadistsRModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory HadistsRModel.fromJson(Map<String, dynamic> json) =>
      _$HadistsRModelFromJson(json);

  Map<String, dynamic> toJson() => _$HadistsRModelToJson(this);
}

@JsonSerializable()
class DataRandomHadists {
  String name, id;
  int available;
  List<ContentsR> contents;

  DataRandomHadists({
    required this.name,
    required this.id,
    required this.available,
    required this.contents,
  });

  factory DataRandomHadists.fromJson(Map<String, dynamic> json) =>
      _$DataRandomHadistsFromJson(json);

  Map<String, dynamic> toJson() => _$DataRandomHadistsToJson(this);
}

@JsonSerializable()
class ContentsR {
  int number;
  String arab, id;

  ContentsR({
    required this.number,
    required this.arab,
    required this.id,
  });

  factory ContentsR.fromJson(Map<String, dynamic> json) =>
      _$ContentsRFromJson(json);

  Map<String, dynamic> toJson() => _$ContentsRToJson(this);
}
