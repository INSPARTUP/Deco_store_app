import 'dart:convert';

import 'package:deco_store_app/models/role.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.numtel,
    this.role,
    this.roles,
    this.accessToken,
  });

  String id;
  String nom;
  String prenom;
  String email;
  String numtel;
  Role role;
  String roles;
  String accessToken;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        numtel: json["numtel"],
        role: Role.fromJson(json["role"]),
        roles: json["roles"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "numtel": numtel,
        "role": role.toJson(),
        "roles": roles,
        "accessToken": accessToken,
      };
}
