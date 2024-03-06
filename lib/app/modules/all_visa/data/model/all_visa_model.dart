import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';

class BaseVisaModel {
  List<CommonModel>? baseGenders;
  List<CommonModel>? baseCountries;
  List<AllowedContreyModel>? baseAllowedCountries;
  List<CommonModel>? baseAccommodationTypes;
  List<CommonModel>? basePassportTypes;
  List<CommonModel>? baseOccupations;

  BaseVisaModel({
    this.baseGenders,
    this.baseCountries,
    this.baseAllowedCountries,
    this.baseAccommodationTypes,
    this.basePassportTypes,
    this.baseOccupations,
  });

  factory BaseVisaModel.fromMap(Map<String, dynamic> json) => BaseVisaModel(
        baseGenders: json["base_genders"] == null
            ? []
            : List<CommonModel>.from(
                json["base_genders"]!.map((x) => CommonModel.fromJson(x))),
        baseCountries: json["base_countries"] == null
            ? []
            : List<CommonModel>.from(
                json["base_countries"]!.map((x) => CommonModel.fromJson(x))),
        baseAllowedCountries: json["base_allowed_countries"] == null
            ? []
            : List<AllowedContreyModel>.from(json["base_allowed_countries"]!
                .map((x) => AllowedContreyModel.fromJson(x))),
        baseAccommodationTypes: json["base_accommodation_types"] == null
            ? []
            : List<CommonModel>.from(json["base_accommodation_types"]!
                .map((x) => CommonModel.fromJson(x))),
        basePassportTypes: json["base_passport_types"] == null
            ? []
            : List<CommonModel>.from(json["base_passport_types"]!
                .map((x) => CommonModel.fromJson(x))),
        baseOccupations: json["base_occupations"] == null
            ? []
            : List<CommonModel>.from(
                json["base_occupations"]!.map((x) => CommonModel.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "base_genders": baseGenders == null
            ? []
            : List<dynamic>.from(baseGenders!.map((x) => x.toString())),
        "base_countries": baseCountries == null
            ? []
            : List<dynamic>.from(baseCountries!.map((x) => x.toString())),
        "base_allowed_countries": baseAllowedCountries == null
            ? []
            : List<dynamic>.from(
                baseAllowedCountries!.map((x) => x.toString())),
        "base_accommodation_types": baseAccommodationTypes == null
            ? []
            : List<dynamic>.from(
                baseAccommodationTypes!.map((x) => x.toString())),
        "base_passport_types": basePassportTypes == null
            ? []
            : List<dynamic>.from(basePassportTypes!.map((x) => x.toString())),
        "base_occupations": baseOccupations == null
            ? []
            : List<dynamic>.from(baseOccupations!.map((x) => x.toString())),
      };
}

class BaseDocAllVisa {
  final List<CommonModel> base_document_types;

  BaseDocAllVisa({
    required this.base_document_types,
  });

  factory BaseDocAllVisa.fromJson(Map<String, dynamic> json) {
    return BaseDocAllVisa(
      base_document_types: List.of(json["base_document_types"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
    );
  }
}
