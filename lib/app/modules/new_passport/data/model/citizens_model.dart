import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';

class IcsApplicationModel {
  String? abroadAddress;
  String? abroadCountryId;
  String? abroadPhoneNumber;
  String? birthCountryId;
  String? nationality_id;
  String? birthPlace;
  String? photo;
  DateTime? createdAt;
  DateTime? dateOfBirth;
  String? eyeColour;
  String? gender;
  String? hairColour;
  double? height;
  String? id;
  String? maritalStatus;
  String? occupation_id;
  String? skinColour;
  bool? is_adopted;

  String? firstName;
  String? father_name;
  String? grand_father_name;
  NameJson? fatherNameJson;
  NameJson? firstNameJson;
  NameJson? grandFatherNameJson;
  final String embassy_id;
  final String current_country_id;
  final List<FamilyModel>? familyModel;

  IcsApplicationModel({
    this.abroadAddress,
    this.abroadCountryId,
    this.abroadPhoneNumber,
    this.birthCountryId,
    this.nationality_id,
    this.birthPlace,
    this.photo,
    this.createdAt,
    this.dateOfBirth,
    this.eyeColour,
    this.gender,
    this.hairColour,
    this.is_adopted,
    this.height,
    this.id,
    this.maritalStatus,
    this.occupation_id,
    this.skinColour,
    this.firstName,
    this.father_name,
    this.grand_father_name,
    this.fatherNameJson,
    this.firstNameJson,
    this.grandFatherNameJson,
    required this.embassy_id,
    required this.current_country_id,
    this.familyModel,
  });

  factory IcsApplicationModel.fromJson(Map<String, dynamic> json) {
    return IcsApplicationModel(
      abroadAddress: json['abroad_address'],
      abroadCountryId: json['abroad_country_id'],
      abroadPhoneNumber: json['phone_number'],
      birthCountryId: json['birth_country_id'],
      photo: json['photo'],
      is_adopted: json['is_adopted'],
      nationality_id: json['nationality_id'],
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
      occupation_id: json['occupation_id'],
      skinColour: json['skin_colour'],
      firstName: json['first_name'],
      father_name: json['father_name'],
      grand_father_name: json['grand_father_name'],
      fatherNameJson: json['father_name_json'] != null
          ? NameJson.fromJson(json['father_name_json'])
          : null,
      firstNameJson: json['first_name_json'] != null
          ? NameJson.fromJson(json['first_name_json'])
          : null,
      grandFatherNameJson: json['grand_father_name_json'] != null
          ? NameJson.fromJson(json['grand_father_name_json'])
          : null,
      embassy_id: json['embassy_id'],
      current_country_id: json['current_country_id'],
      familyModel: List.of(json["citizen_families"])
          .map((i) => FamilyModel.fromJson(i))
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
