class Basemodel {
  final List<CommonModel> base_genders;
  final List<CommonModel> base_marital_statuses;
  final List<CommonJsonModel> base_countries;
  final List<CommonIDModel> base_document_types;

  Basemodel({
    required this.base_genders,
    required this.base_marital_statuses,
    required this.base_countries,
    required this.base_document_types,
  });

  factory Basemodel.fromJson(Map<String, dynamic> json) {
    return Basemodel(
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
