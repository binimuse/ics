class Basemodel {
  final List<CommonModel> base_genders;
  final List<CommonJsonModel> base_occupations;
  final List<CommonJsonModel> base_family_types;
  final List<CommonModel> base_hair_colors;
  final List<CommonModel> base_eye_colors;
  final List<CommonModel> base_marital_statuses;
  final List<CommonJsonModel> base_countries;
  final List<AllowedContreyModel> allowed_countries;
  final List<CommonIDModel> base_document_types;

  Basemodel({
    required this.base_genders,
    required this.base_occupations,
    required this.base_family_types,
    required this.base_eye_colors,
    required this.base_hair_colors,
    required this.base_marital_statuses,
    required this.base_countries,
    required this.base_document_types,
    required this.allowed_countries,
  });

  factory Basemodel.fromJson(Map<String, dynamic> json) {
    return Basemodel(
      base_family_types: List.of(json["base_family_types"])
          .map((i) => CommonJsonModel.fromJson(i))
          .toList(),
      base_occupations: List.of(json["base_occupations"])
          .map((i) => CommonJsonModel.fromJson(i))
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
          .map((i) => CommonJsonModel.fromJson(i))
          .toList(),
      base_document_types: List.of(json["base_document_types"])
          .map((i) => CommonIDModel.fromJson(i))
          .toList(),
      allowed_countries: List.of(json["base_allowed_countries"])
          .map((i) => AllowedContreyModel.fromJson(i))
          .toList(),
    );
  }
}

class CommonModel {
  final String description;
  final String name;

  const CommonModel({
    required this.description,
    required this.name,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(name: json['name'], description: json['description']);
  }
}

class CommonJsonModel {
  final String id;
  final String name_json;

  const CommonJsonModel({
    required this.id,
    required this.name_json,
  });

  factory CommonJsonModel.fromJson(Map<String, dynamic> json) {
    return CommonJsonModel(
      id: json['id'],
      name_json: json['name_json']['name'],
    );
  }
}

class AllowedContreyModel {
  final String id;
  final String name_json;

  const AllowedContreyModel({
    required this.id,
    required this.name_json,
  });

  factory AllowedContreyModel.fromJson(Map<String, dynamic> json) {
    return AllowedContreyModel(
      id: json['country']['id'],
      name_json: json['country']['name_json']['name'],
    );
  }
}

class CommonIDModel {
  final String id;
  final String name;

  const CommonIDModel({
    required this.id,
    required this.name,
  });

  factory CommonIDModel.fromJson(Map<String, dynamic> json) {
    return CommonIDModel(name: json['name'], id: json['id']);
  }
}

class FamilyModel {
  final CommonJsonModel? family_type;
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
        family_type: CommonJsonModel.fromJson(json['family_type']),
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
