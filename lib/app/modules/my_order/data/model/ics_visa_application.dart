class IcsVisaApplication {
  String id;
  DateTime createdAt;
  String applicationNo;
  AbroadCountry abroadCountry;
  String accommodationCity;
  String accommodationName;
  String accommodationStreetAddress;
  String accommodationTelephone;
  AbroadCountry accommodationType;
  String airline;
  DateTime arrivalDate;
  AbroadCountry birthCountry;
  DateTime birthDate;
  String city;
  String companyReferenceNumber;
  String createdById;
  String departureCity;
  AbroadCountry departureCountry;
  String departureCountryId;
  String email;
  String flightNumber;
  DateTime passportExpiryDate;
  DateTime passportIssuedDate;
  String passportIssuingAuthority;
  AbroadCountry passportIssuingCountry;
  String passportNumber;
  String streetAddress;

  String surname;
  VisaCategoryValidityType visaCategoryValidityType;

  IcsVisaApplication({
    required this.id,
    required this.createdAt,
    required this.applicationNo,
    required this.abroadCountry,
    required this.accommodationCity,
    required this.accommodationName,
    required this.accommodationStreetAddress,
    required this.accommodationTelephone,
    required this.accommodationType,
    required this.airline,
    required this.arrivalDate,
    required this.birthCountry,
    required this.birthDate,
    required this.city,
    required this.companyReferenceNumber,
    required this.createdById,
    required this.departureCity,
    required this.departureCountry,
    required this.departureCountryId,
    required this.email,
    required this.flightNumber,
    required this.passportExpiryDate,
    required this.passportIssuedDate,
    required this.passportIssuingAuthority,
    required this.passportIssuingCountry,
    required this.passportNumber,
    required this.streetAddress,
    required this.surname,
    required this.visaCategoryValidityType,
  });

  factory IcsVisaApplication.fromJson(Map<String, dynamic> json) =>
      IcsVisaApplication(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        applicationNo: json["application_no"],
        abroadCountry: AbroadCountry.fromJson(json["abroad_country"]),
        accommodationCity: json["accommodation_city"],
        accommodationName: json["accommodation_name"],
        accommodationStreetAddress: json["accommodation_street_address"],
        accommodationTelephone: json["accommodation_telephone"],
        accommodationType: AbroadCountry.fromJson(json["accommodation_type"]),
        airline: json["airline"],
        arrivalDate: DateTime.parse(json["arrival_date"]),
        birthCountry: AbroadCountry.fromJson(json["birth_country"]),
        birthDate: DateTime.parse(json["birth_date"]),
        city: json["city"],
        companyReferenceNumber: json["company_reference_number"],
        createdById: json["created_by_id"],
        departureCity: json["departure_city"],
        departureCountry: AbroadCountry.fromJson(json["departure_country"]),
        departureCountryId: json["departure_country_id"],
        email: json["email"],
        flightNumber: json["flight_number"],
        passportExpiryDate: DateTime.parse(json["passport_expiry_date"]),
        passportIssuedDate: DateTime.parse(json["passport_issued_date"]),
        passportIssuingAuthority: json["passport_issuing_authority"],
        passportIssuingCountry:
            AbroadCountry.fromJson(json["passport_issuing_country"]),
        passportNumber: json["passport_number"],
        streetAddress: json["street_address"],
        surname: json["surname"],
        visaCategoryValidityType: VisaCategoryValidityType.fromJson(
            json["visa_category_validity_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "application_no": applicationNo,
        "abroad_country": abroadCountry.toJson(),
        "accommodation_city": accommodationCity,
        "accommodation_name": accommodationName,
        "accommodation_street_address": accommodationStreetAddress,
        "accommodation_telephone": accommodationTelephone,
        "accommodation_type": accommodationType.toJson(),
        "airline": airline,
        "arrival_date":
            "${arrivalDate.year.toString().padLeft(4, '0')}-${arrivalDate.month.toString().padLeft(2, '0')}-${arrivalDate.day.toString().padLeft(2, '0')}",
        "birth_country": birthCountry.toJson(),
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "city": city,
        "company_reference_number": companyReferenceNumber,
        "created_by_id": createdById,
        "departure_city": departureCity,
        "departure_country": departureCountry.toJson(),
        "departure_country_id": departureCountryId,
        "email": email,
        "flight_number": flightNumber,
        "passport_expiry_date":
            "${passportExpiryDate.year.toString().padLeft(4, '0')}-${passportExpiryDate.month.toString().padLeft(2, '0')}-${passportExpiryDate.day.toString().padLeft(2, '0')}",
        "passport_issued_date":
            "${passportIssuedDate.year.toString().padLeft(4, '0')}-${passportIssuedDate.month.toString().padLeft(2, '0')}-${passportIssuedDate.day.toString().padLeft(2, '0')}",
        "passport_issuing_authority": passportIssuingAuthority,
        "passport_issuing_country": passportIssuingCountry.toJson(),
        "passport_number": passportNumber,
        "street_address": streetAddress,
        "surname": surname,
        "visa_category_validity_type": visaCategoryValidityType.toJson(),
      };
}

class AbroadCountry {
  String id;
  String name;

  AbroadCountry({
    required this.id,
    required this.name,
  });

  factory AbroadCountry.fromJson(Map<String, dynamic> json) => AbroadCountry(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class VisaCategoryValidityType {
  String id;
  AbroadCountry visaCategory;
  AbroadCountry visaValidityType;

  VisaCategoryValidityType({
    required this.id,
    required this.visaCategory,
    required this.visaValidityType,
  });

  factory VisaCategoryValidityType.fromJson(Map<String, dynamic> json) =>
      VisaCategoryValidityType(
        id: json["id"],
        visaCategory: AbroadCountry.fromJson(json["visa_category"]),
        visaValidityType: AbroadCountry.fromJson(json["visa_validity_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "visa_category": visaCategory.toJson(),
        "visa_validity_type": visaValidityType.toJson(),
      };
}
