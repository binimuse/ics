class IcsCitizenModel {
  String? abroadAddress;
  String? abroadCountryId;
  String? abroadPhoneNumber;
  String? birthCountryId;
  String? birthPlace;
  DateTime? createdAt;
  DateTime? dateOfBirth;
  String? eyeColour;
  String? gender;
  String? hairColour;
  double? height;
  String? id;
  String? maritalStatus;
  String? occupation;
  String? skinColour;

  String? firstName;
  String? father_name;
  NameJson? fatherNameJson;
  NameJson? firstNameJson;
  NameJson? grandFatherNameJson;
  final List<NewApplicationModel>? newApplicationModel;

  IcsCitizenModel({
    this.abroadAddress,
    this.abroadCountryId,
    this.abroadPhoneNumber,
    this.birthCountryId,
    this.birthPlace,
    this.createdAt,
    this.dateOfBirth,
    this.eyeColour,
    this.gender,
    this.hairColour,
    this.height,
    this.id,
    this.maritalStatus,
    this.occupation,
    this.skinColour,
    this.firstName,
    this.father_name,
    this.fatherNameJson,
    this.firstNameJson,
    this.grandFatherNameJson,
    this.newApplicationModel,
  });

  factory IcsCitizenModel.fromJson(Map<String, dynamic> json) {
    return IcsCitizenModel(
      abroadAddress: json['abroad_address'],
      abroadCountryId: json['abroad_country_id'],
      abroadPhoneNumber: json['abroad_phone_number'],
      birthCountryId: json['birth_country_id'],
      birthPlace: json['birth_place'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      eyeColour: json['eye_colour'],
      gender: json['gender'],
      hairColour: json['hair_colour'],
      height: json['height'] != null ? json['height'].toDouble() : null,
      id: json['id'],
      maritalStatus: json['marital_status'],
      occupation: json['occupation'],
      skinColour: json['skin_colour'],
      firstName: json['first_name'],
      father_name: json['father_name'],
      fatherNameJson: json['father_name_json'] != null
          ? NameJson.fromJson(json['father_name_json'])
          : null,
      firstNameJson: json['first_name_json'] != null
          ? NameJson.fromJson(json['first_name_json'])
          : null,
      grandFatherNameJson: json['grand_father_name_json'] != null
          ? NameJson.fromJson(json['grand_father_name_json'])
          : null,
      newApplicationModel: List.of(json["new_applications"])
          .map((i) => NewApplicationModel.fromJson(i))
          .toList(),
    );
  }
}

class NameJson {
  String? am;
  String? en;

  NameJson({
    this.am,
    this.en,
  });

  factory NameJson.fromJson(Map<String, dynamic> json) {
    return NameJson(
      am: json['am'],
      en: json['en'],
    );
  }
}

class NewApplicationModel {
  final String embassy_id;

  const NewApplicationModel({
    required this.embassy_id,
  });

  factory NewApplicationModel.fromJson(Map<String, dynamic> json) {
    return NewApplicationModel(
      embassy_id: json['embassy_id'],
    );
  }
}
