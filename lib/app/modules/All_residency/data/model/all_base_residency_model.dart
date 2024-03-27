import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';

class BaseResidencyModel {
  List<CommonModel>? baseGenders;
  List<CommonModel>? baseCountries;
  List<CommonModel>? baseCompanyCategories;
  List<AllowedContreyModel>? baseAllowedCountries;
  List<CommonModel>? baseAccommodationTypes;
  List<CommonModel>? basePassportTypes;
  List<CommonModel>? baseRegions;
  List<CommonModel>? baseOccupations;
  List<BaseResidencyApplicationUrgencyLevel>
      baseResidencyApplicationUrgencyLevels;

  BaseResidencyModel({
    this.baseGenders,
    this.baseCountries,
    this.baseAllowedCountries,
    this.baseCompanyCategories,
    this.baseAccommodationTypes,
    this.basePassportTypes,
    this.baseRegions,
    this.baseOccupations,
    required this.baseResidencyApplicationUrgencyLevels,
  });

  factory BaseResidencyModel.fromMap(Map<String, dynamic> json) =>
      BaseResidencyModel(
        baseCompanyCategories: List<CommonModel>.from(
            json["base_company_categories"]
                .map((x) => CommonModel.fromJson(x))),
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
        baseRegions: List<CommonModel>.from(
            json["base_regions"].map((x) => CommonModel.fromJson(x))),
        basePassportTypes: json["base_passport_types"] == null
            ? []
            : List<CommonModel>.from(json["base_passport_types"]!
                .map((x) => CommonModel.fromJson(x))),
        baseOccupations: json["base_occupations"] == null
            ? []
            : List<CommonModel>.from(
                json["base_occupations"]!.map((x) => CommonModel.fromJson(x))),
        baseResidencyApplicationUrgencyLevels:
            List<BaseResidencyApplicationUrgencyLevel>.from(
                json["base_residency_application_urgency_levels"].map(
                    (x) => BaseResidencyApplicationUrgencyLevel.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "base_company_categories":
            List<dynamic>.from(baseCompanyCategories!.map((x) => x.toString())),
        "base_regions":
            List<dynamic>.from(baseRegions!.map((x) => x.toString())),
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
        "base_residency_application_urgency_levels": List<dynamic>.from(
            baseResidencyApplicationUrgencyLevels.map((x) => x.toJson())),
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

class BaseResidencyApplicationUrgencyLevel {
  String code;
  String name;
  String id;
  int price;

  BaseResidencyApplicationUrgencyLevel({
    required this.code,
    required this.name,
    required this.id,
    required this.price,
  });

  factory BaseResidencyApplicationUrgencyLevel.fromJson(
          Map<String, dynamic> json) =>
      BaseResidencyApplicationUrgencyLevel(
        code: json["code"],
        name: json["name"],
        id: json["id"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "id": id,
        "price": price,
      };
}
