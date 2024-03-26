class BaseResidencyTypeModel {
  String? id;
  String? name;
  DocumentCategory? documentCategory;

  BaseResidencyTypeModel({
    this.id,
    this.name,
    this.documentCategory,
  });

  factory BaseResidencyTypeModel.fromJson(Map<String, dynamic> json) =>
      BaseResidencyTypeModel(
        id: json["id"],
        name: json["name"],
        documentCategory: DocumentCategory.fromJson(json["document_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "document_category": documentCategory!.toJson(),
      };
}

class DocumentCategory {
  String id;
  String name;
  String code;

  DocumentCategory({
    required this.id,
    required this.name,
    required this.code,
  });

  factory DocumentCategory.fromJson(Map<String, dynamic> json) =>
      DocumentCategory(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
