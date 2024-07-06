import 'package:json_annotation/json_annotation.dart';
import 'package:my_grocery/src/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;
  DateTime? createdDateTime;
  @JsonKey(name: 'due')
  DateTime overDudeDateTime;
  @JsonKey(defaultValue: [])
  List<CartItemModel> items;
  String status;
  @JsonKey(name: 'copiaecola')
  String copyAndPaste;
  double total;
  String qrCodeImage;

  OrderModel({
    required this.id,
    this.createdDateTime,
    required this.overDudeDateTime,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    required this.qrCodeImage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
