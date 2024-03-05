class BaseVisaTypeModel {
  String? id;
  String? name;
  List<VisaCategoryValidityType>? visaCategoryValidityTypes;

  BaseVisaTypeModel({
    this.id,
    this.name,
    this.visaCategoryValidityTypes,
  });

  factory BaseVisaTypeModel.fromMap(Map<String, dynamic> json) =>
      BaseVisaTypeModel(
        id: json["id"],
        name: json["name"],
        visaCategoryValidityTypes: json["visa_category_validity_types"] == null
            ? []
            : List<VisaCategoryValidityType>.from(
                json["visa_category_validity_types"]!
                    .map((x) => VisaCategoryValidityType.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "visa_category_validity_types": visaCategoryValidityTypes == null
            ? []
            : List<dynamic>.from(
                visaCategoryValidityTypes!.map((x) => x.toMap())),
      };
}

class VisaCategoryValidityType {
  String? id;
  int? price;
  VisaCategory? visaCategory;
  VisaValidityType? visaValidityType;

  VisaCategoryValidityType({
    this.id,
    this.price,
    this.visaCategory,
    this.visaValidityType,
  });

  factory VisaCategoryValidityType.fromMap(Map<String, dynamic> json) =>
      VisaCategoryValidityType(
        id: json["id"],
        price: json["price"],
        visaCategory: json["visa_category"] == null
            ? null
            : VisaCategory.fromMap(json["visa_category"]),
        visaValidityType: json["visa_validity_type"] == null
            ? null
            : VisaValidityType.fromMap(json["visa_validity_type"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "visa_category": visaCategory?.toMap(),
        "visa_validity_type": visaValidityType?.toMap(),
      };
}

class VisaCategory {
  DocumentCategory? documentCategory;

  VisaCategory({
    this.documentCategory,
  });

  factory VisaCategory.fromMap(Map<String, dynamic> json) => VisaCategory(
        documentCategory: json["document_category"] == null
            ? null
            : DocumentCategory.fromMap(json["document_category"]),
      );

  Map<String, dynamic> toMap() => {
        "document_category": documentCategory?.toMap(),
      };
}

class DocumentCategory {
  String? id;
  String? name;

  DocumentCategory({
    this.id,
    this.name,
  });

  factory DocumentCategory.fromMap(Map<String, dynamic> json) =>
      DocumentCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class VisaValidityType {
  String? name;
  String? description;

  VisaValidityType({
    this.name,
    this.description,
  });

  factory VisaValidityType.fromMap(Map<String, dynamic> json) =>
      VisaValidityType(
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
      };
}
