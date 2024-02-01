class ReNewOrginIdConfirmationModel {
  final String name;
  final String image;
  final String description;

  ReNewOrginIdConfirmationModel({
    required this.name,
    required this.image,
    required this.description,
  });

  factory ReNewOrginIdConfirmationModel.fromJson(Map<String, dynamic> json) {
    return ReNewOrginIdConfirmationModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
