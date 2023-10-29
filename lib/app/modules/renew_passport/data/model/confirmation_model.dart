class ConfirmationModel {
  final String name;
  final String image;
  final String description;

  ConfirmationModel({
    required this.name,
    required this.image,
    required this.description,
  });

  factory ConfirmationModel.fromJson(Map<String, dynamic> json) {
    return ConfirmationModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
