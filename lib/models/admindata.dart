import 'dart:convert';

AdminData adminDataFromJson(String str) => AdminData.fromJson(json.decode(str));

String adminDataToJson(AdminData data) => json.encode(data.toJson());

class AdminData {
  AdminData({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.numtel,
    this.roles,
    this.password,
  });

  String id;
  String nom;
  String prenom;
  String email;
  String numtel;
  String roles;
  String password;

  factory AdminData.fromJson(Map<String, dynamic> json) => AdminData(
        id: json["_id"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        numtel: json["numtel"],
        roles: json["roles"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "numtel": numtel,
        "roles": roles,
        "password": password,
      };
}
