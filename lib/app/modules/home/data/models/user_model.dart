class UsersByPk {

  String? email;
  String? name;
  String? id;
  String? phoneNumber;

  UsersByPk({
   
    this.email,
    this.name,
    this.id,
    this.phoneNumber,
  });

  factory UsersByPk.fromJson(Map<String, dynamic> json) => UsersByPk(
      
        email: json['email'],
        name: json['name'],
        id: json['id'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
       
        'email': email,
        'name': name,
        'id': id,
        'phoneNumber': phoneNumber,
      };
}
