class Role {
  Role({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
