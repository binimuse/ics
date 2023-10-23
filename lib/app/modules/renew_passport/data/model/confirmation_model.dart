class ConfirmationModel {
  final String name;
  final String image;

  ConfirmationModel({
    required this.name,
    required this.image,
  });

  factory ConfirmationModel.fromJson(Map<String, dynamic> json) {
    return ConfirmationModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
