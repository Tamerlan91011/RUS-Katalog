import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  final int id;
  String email;
  String phone;
  String password;
  String fullname;
  bool isAdmin;

  Client(
      {required this.id,
      required this.email,
      required this.phone,
      required this.password,
      required this.fullname,
      required this.isAdmin});

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
