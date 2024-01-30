class NewOrginIdConfirmationModel {
  final String name;
  final String image;
  final String description;

  NewOrginIdConfirmationModel({
    required this.name,
    required this.image,
    required this.description,
  });

  factory NewOrginIdConfirmationModel.fromJson(Map<String, dynamic> json) {
    return NewOrginIdConfirmationModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
