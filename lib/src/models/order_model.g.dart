// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      createdDateTime: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      overDudeDateTime: DateTime.parse(json['due'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String,
      copyAndPaste: json['copiaecola'] as String,
      total: (json['total'] as num).toDouble(),
      qrCodeImage: json['qrCodeImage'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdDateTime?.toIso8601String(),
      'due': instance.overDudeDateTime.toIso8601String(),
      'items': instance.items,
      'status': instance.status,
      'copiaecola': instance.copyAndPaste,
      'total': instance.total,
      'qrCodeImage': instance.qrCodeImage,
    };
