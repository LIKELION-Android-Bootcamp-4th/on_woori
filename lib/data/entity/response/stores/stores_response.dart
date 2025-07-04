import 'package:json_annotation/json_annotation.dart';

part 'stores_response.g.dart';

@JsonSerializable()
class StoresResponse {
  final bool success;
  final String message;
  final List<StoreItem> data;
  final DateTime timestamp;

  StoresResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

@JsonSerializable()
class StoreItem {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String? description;
  final String owner;

  StoreItem({
    required this.id,
    required this.name,
    this.description,
    required this.owner,
  });

  factory StoreItem.fromJson(Map<String, dynamic> json) =>
      _$StoreItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoreItemToJson(this);
}