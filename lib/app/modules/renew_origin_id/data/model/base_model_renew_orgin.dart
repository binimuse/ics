class BasemodelRenewOrginId {
  final List<CommonModel> base_genders;
  final List<CommonModel> base_occupations;

  final List<CommonModel> base_hair_colors;
  final List<CommonModel> base_eye_colors;
  final List<CommonModel> base_marital_statuses;
  final List<CommonModel> base_countries;
  final List<CommonModel> base_correction_types;
  final List<AllowedContreyModel> allowed_countries;
  final List<CommonModel> base_document_types;
  final List<CommonModel> base_visa_types;

  BasemodelRenewOrginId({
    required this.base_genders,
    required this.base_occupations,
    required this.base_eye_colors,
    required this.base_hair_colors,
    required this.base_marital_statuses,
    required this.base_countries,
    required this.base_correction_types,
    required this.base_document_types,
    required this.allowed_countries,
    required this.base_visa_types,
  });

  factory BasemodelRenewOrginId.fromJson(Map<String, dynamic> json) {
    return BasemodelRenewOrginId(
      base_occupations: List.of(json["base_occupations"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      base_eye_colors: List.of(json["base_eye_colors"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      base_hair_colors: List.of(json["base_hair_colors"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      base_genders: List.of(json["base_genders"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      base_marital_statuses: List.of(json["base_marital_statuses"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      base_countries: List.of(json["base_countries"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      base_document_types: List.of(json["base_document_types"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      allowed_countries: List.of(json["base_allowed_countries"])
          .map((i) => AllowedContreyModel.fromJson(i))
          .toList(),
      base_visa_types: List.of(json["base_visa_types"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
      base_correction_types: List.of(json["base_correction_types"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
    );
  }
}

class CommonModel {
  final String? description;
  final String? id;
  final String name;

  const CommonModel({
    this.description,
    required this.name,
    this.id,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        name: json['name'],
        id: json['id'] ?? "",
        description: json['description'] ?? "");
  }
}

class AllowedContreyModel {
  final String id;
  final String name;

  const AllowedContreyModel({
    required this.id,
    required this.name,
  });

  factory AllowedContreyModel.fromJson(Map<String, dynamic> json) {
    return AllowedContreyModel(
      id: json['country']['id'],
      name: json['country']['name'],
    );
  }
}

class FamilyModel {
  final CommonModel? family_type;
  final String? nationality_id;
  final String? first_name;
  final String? father_name;

  const FamilyModel({
    this.nationality_id,
    this.family_type,
    this.first_name,
    this.father_name,
  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    return FamilyModel(
        family_type: CommonModel.fromJson(json['family_type']),
        nationality_id: json['nationality_id'],
        father_name: json['father_name'],
        first_name: json['first_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      "family_type_id": family_type!.id,
      'first_name': father_name,
      'nationality_id': nationality_id,
      'father_name': first_name,
    };
  }
}
