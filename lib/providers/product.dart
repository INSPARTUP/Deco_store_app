// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product with ChangeNotifier {
  Product({
    this.nom,
    this.type,
    this.prix,
    this.quantite,
    this.description,
    this.imageurl,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String nom;
  String type;
  int prix;
  int quantite;
  String description;
  String imageurl;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        nom: json["nom"],
        type: json["type"],
        prix: json["prix"],
        quantite: json["quantite"],
        description: json["description"],
        imageurl: json["imageurl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "type": type,
        "prix": prix,
        "quantite": quantite,
        "description": description,
        "imageurl": imageurl,
        //   "createdAt": createdAt.toIso8601String(),
        //   "updatedAt": updatedAt.toIso8601String(),
        //   "id": id,
      };
}
