class NewConfirmationModel {
  final String name;
  final String image;
  final String description;

  NewConfirmationModel({
    required this.name,
    required this.image,
    required this.description,
  });

  factory NewConfirmationModel.fromJson(Map<String, dynamic> json) {
    return NewConfirmationModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
