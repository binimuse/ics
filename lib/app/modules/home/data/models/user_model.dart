class UserModel {
  Data? data;

  UserModel({
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
      };
}

class Data {
  UsersByPk usersByPk;

  Data({
    required this.usersByPk,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersByPk: UsersByPk.fromJson(json['usersByPk']),
      );

  Map<String, dynamic> toJson() => {
        'usersByPk': usersByPk.toJson(),
      };
}

class UsersByPk {
  DateTime createdAt;
  String email;
  String name;
  String id;
  String phoneNumber;

  UsersByPk({
    required this.createdAt,
    required this.email,
    required this.name,
    required this.id,
    required this.phoneNumber,
  });

  factory UsersByPk.fromJson(Map<String, dynamic> json) => UsersByPk(
        createdAt: DateTime.parse(json['createdAt']),
        email: json['email'],
        name: json['name'],
        id: json['id'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'email': email,
        'name': name,
        'id': id,
        'phoneNumber': phoneNumber,
      };
}
