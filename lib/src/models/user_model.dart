import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
  @JsonKey(name: 'fullname')
  String? name;
  String? email;
  String? cellphone;
  String? cpf;
  String? pass;
  String? id;
  String? token;

  UserModel({
     this.name,
     this.email,
     this.cellphone,
     this.cpf,
     this.pass,
     this.id,
     this.token
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, cellphone: $cellphone, cpf: $cpf, pass: $pass, id: $id, token: $token}';
  }
}