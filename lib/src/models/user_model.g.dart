// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['fullname'] as String?,
      email: json['email'] as String?,
      cellphone: json['cellphone'] as String?,
      cpf: json['cpf'] as String?,
      pass: json['pass'] as String?,
      id: json['id'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fullname': instance.name,
      'email': instance.email,
      'cellphone': instance.cellphone,
      'cpf': instance.cpf,
      'pass': instance.pass,
      'id': instance.id,
      'token': instance.token,
    };
