class BaseVisaTypeModel {
  String? id;
  String? name;
  DocumentCategory? documentCategory;
  List<VisaCategoryValidityType>? visaCategoryValidityTypes;

  BaseVisaTypeModel({
    this.id,
    this.name,
    this.documentCategory,
    this.visaCategoryValidityTypes,
  });

  factory BaseVisaTypeModel.fromJson(Map<String, dynamic> json) =>
      BaseVisaTypeModel(
        id: json["id"],
        name: json["name"],
        documentCategory: DocumentCategory.fromJson(json["document_category"]),
        visaCategoryValidityTypes: List<VisaCategoryValidityType>.from(
            json["visa_category_validity_types"]
                .map((x) => VisaCategoryValidityType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "document_category": documentCategory!.toJson(),
        "visa_category_validity_types": List<dynamic>.from(
            visaCategoryValidityTypes!.map((x) => x.toJson())),
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

class VisaCategoryValidityType {
  String id;
  int price;
  VisaValidityType visaValidityType;

  VisaCategoryValidityType({
    required this.id,
    required this.price,
    required this.visaValidityType,
  });

  factory VisaCategoryValidityType.fromJson(Map<String, dynamic> json) =>
      VisaCategoryValidityType(
        id: json["id"],
        price: json["price"],
        visaValidityType: VisaValidityType.fromJson(json["visa_validity_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "visa_validity_type": visaValidityType.toJson(),
      };
}

class VisaValidityType {
  String name;
  String description;

  VisaValidityType({
    required this.name,
    required this.description,
  });

  factory VisaValidityType.fromJson(Map<String, dynamic> json) =>
      VisaValidityType(
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };
}
