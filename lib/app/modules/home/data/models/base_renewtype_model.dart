class RenewTypeModel {
  final String? description;
  final String? id;
  final String name;
  final String document_category_code;

  const RenewTypeModel({
    this.description,
    required this.name,
    required this.document_category_code,
    this.id,
  });

  factory RenewTypeModel.fromJson(Map<String, dynamic> json) {
    return RenewTypeModel(
        name: json['name'],
        document_category_code: json['document_category_code'],
        id: json['id'] ?? "",
        description: json['description'] ?? "");
  }
}
