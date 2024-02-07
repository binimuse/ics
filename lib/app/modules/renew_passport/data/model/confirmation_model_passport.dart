class ReNewPassportConfirmationModel {
  final String name;
  final String image;
  final String description;

  ReNewPassportConfirmationModel({
    required this.name,
    required this.image,
    required this.description,
  });

  factory ReNewPassportConfirmationModel.fromJson(Map<String, dynamic> json) {
    return ReNewPassportConfirmationModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
