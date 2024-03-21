class IcsCompanies {
  String id;
  String name;
  String email;

  IcsCompanies({
    required this.id,
    required this.name,
    required this.email,
  });

  factory IcsCompanies.fromJson(Map<String, dynamic> json) => IcsCompanies(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
