import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';

class IcsVisaApplication {
  String id;
  String applicationNo;
  String companyReferenceNumber;
  String reviewStatus;
  DateTime createdAt;
  String givenName;
  String surname;
  String gender;
  AbroadCountry nationality;
  AbroadCountry birthCountry;
  DateTime birthDate;
  String birthPlace;
  String email;
  AbroadCountry occupation;
  AbroadCountry abroadCountry;
  String city;
  String streetAddress;
  String phoneNumber;
  DateTime arrivalDate;
  AbroadCountry departureCountry;
  String departureCity;
  String airline;
  String flightNumber;
  AbroadCountry accommodationType;
  String accommodationName;
  String accommodationCity;
  String accommodationStreetAddress;
  String accommodationTelephone;
  String passportNumber;
  AbroadCountry passportType;
  DateTime passportIssuedDate;
  DateTime passportExpiryDate;
  AbroadCountry passportIssuingCountry;
  String passportIssuingAuthority;
  VisaCategoryValidityType visaCategoryValidityType;
  List<VisaApplicationDocument> visaApplicationDocuments;

  IcsVisaApplication({
    required this.id,
    required this.applicationNo,
    required this.companyReferenceNumber,
    required this.reviewStatus,
    required this.createdAt,
    required this.givenName,
    required this.surname,
    required this.gender,
    required this.nationality,
    required this.birthCountry,
    required this.birthDate,
    required this.birthPlace,
    required this.email,
    required this.occupation,
    required this.abroadCountry,
    required this.city,
    required this.streetAddress,
    required this.phoneNumber,
    required this.arrivalDate,
    required this.departureCountry,
    required this.departureCity,
    required this.airline,
    required this.flightNumber,
    required this.accommodationType,
    required this.accommodationName,
    required this.accommodationCity,
    required this.accommodationStreetAddress,
    required this.accommodationTelephone,
    required this.passportNumber,
    required this.passportType,
    required this.passportIssuedDate,
    required this.passportExpiryDate,
    required this.passportIssuingCountry,
    required this.passportIssuingAuthority,
    required this.visaCategoryValidityType,
    required this.visaApplicationDocuments,
  });

  factory IcsVisaApplication.fromJson(Map<String, dynamic> json) =>
      IcsVisaApplication(
        id: json["id"],
        applicationNo: json["application_no"],
        companyReferenceNumber: json["company_reference_number"],
        reviewStatus: json["review_status"],
        createdAt: DateTime.parse(json["created_at"]),
        givenName: json["given_name"],
        surname: json["surname"],
        gender: json["gender"],
        nationality: AbroadCountry.fromJson(json["nationality"]),
        birthCountry: AbroadCountry.fromJson(json["birth_country"]),
        birthDate: DateTime.parse(json["birth_date"]),
        birthPlace: json["birth_place"],
        email: json["email"],
        occupation: AbroadCountry.fromJson(json["occupation"]),
        abroadCountry: AbroadCountry.fromJson(json["abroad_country"]),
        city: json["city"],
        streetAddress: json["street_address"],
        phoneNumber: json["phone_number"],
        arrivalDate: DateTime.parse(json["arrival_date"]),
        departureCountry: AbroadCountry.fromJson(json["departure_country"]),
        departureCity: json["departure_city"],
        airline: json["airline"],
        flightNumber: json["flight_number"],
        accommodationType: AbroadCountry.fromJson(json["accommodation_type"]),
        accommodationName: json["accommodation_name"],
        accommodationCity: json["accommodation_city"],
        accommodationStreetAddress: json["accommodation_street_address"],
        accommodationTelephone: json["accommodation_telephone"],
        passportNumber: json["passport_number"],
        passportType: AbroadCountry.fromJson(json["passport_type"]),
        passportIssuedDate: DateTime.parse(json["passport_issued_date"]),
        passportExpiryDate: DateTime.parse(json["passport_expiry_date"]),
        passportIssuingCountry:
            AbroadCountry.fromJson(json["passport_issuing_country"]),
        passportIssuingAuthority: json["passport_issuing_authority"],
        visaCategoryValidityType: VisaCategoryValidityType.fromJson(
            json["visa_category_validity_type"]),
        visaApplicationDocuments: List<VisaApplicationDocument>.from(
            json["visa_application_documents"]
                .map((x) => VisaApplicationDocument.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "application_no": applicationNo,
        "company_reference_number": companyReferenceNumber,
        "review_status": reviewStatus,
        "created_at": createdAt.toIso8601String(),
        "given_name": givenName,
        "surname": surname,
        "gender": gender,
        "nationality": nationality.toJson(),
        "birth_country": birthCountry.toJson(),
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "birth_place": birthPlace,
        "email": email,
        "occupation": occupation.toJson(),
        "abroad_country": abroadCountry.toJson(),
        "city": city,
        "street_address": streetAddress,
        "phone_number": phoneNumber,
        "arrival_date":
            "${arrivalDate.year.toString().padLeft(4, '0')}-${arrivalDate.month.toString().padLeft(2, '0')}-${arrivalDate.day.toString().padLeft(2, '0')}",
        "departure_country": departureCountry.toJson(),
        "departure_city": departureCity,
        "airline": airline,
        "flight_number": flightNumber,
        "accommodation_type": accommodationType.toJson(),
        "accommodation_name": accommodationName,
        "accommodation_city": accommodationCity,
        "accommodation_street_address": accommodationStreetAddress,
        "accommodation_telephone": accommodationTelephone,
        "passport_number": passportNumber,
        "passport_type": passportType.toJson(),
        "passport_issued_date":
            "${passportIssuedDate.year.toString().padLeft(4, '0')}-${passportIssuedDate.month.toString().padLeft(2, '0')}-${passportIssuedDate.day.toString().padLeft(2, '0')}",
        "passport_expiry_date":
            "${passportExpiryDate.year.toString().padLeft(4, '0')}-${passportExpiryDate.month.toString().padLeft(2, '0')}-${passportExpiryDate.day.toString().padLeft(2, '0')}",
        "passport_issuing_country": passportIssuingCountry.toJson(),
        "passport_issuing_authority": passportIssuingAuthority,
        "visa_category_validity_type": visaCategoryValidityType.toJson(),
        "visa_application_documents":
            List<dynamic>.from(visaApplicationDocuments.map((x) => x.toJson())),
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

class VisaApplicationDocument {
  CurrentCountry documentType;
  Files files;
  String reviewStatus;
  dynamic verifierNote;
  dynamic rejecterNote;
  dynamic rejectedAt;

  VisaApplicationDocument({
    required this.documentType,
    required this.files,
    required this.reviewStatus,
    required this.verifierNote,
    required this.rejecterNote,
    required this.rejectedAt,
  });

  factory VisaApplicationDocument.fromJson(Map<String, dynamic> json) =>
      VisaApplicationDocument(
        documentType: CurrentCountry.fromMap(json["document_type"]),
        files: Files.fromJson(json["files"]),
        reviewStatus: json["review_status"],
        verifierNote: json["verifier_note"],
        rejecterNote: json["rejecter_note"],
        rejectedAt: json["rejected_at"],
      );

  Map<String, dynamic> toJson() => {
        "document_type": documentType.toMap(),
        "files": files.toJson(),
        "review_status": reviewStatus,
        "verifier_note": verifierNote,
        "rejecter_note": rejecterNote,
        "rejected_at": rejectedAt,
      };
}

class Files {
  String path;

  Files({
    required this.path,
  });

  factory Files.fromJson(Map<String, dynamic> json) => Files(
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
      };
}

class VisaCategoryValidityType {
  String id;
  int price;
  AbroadCountry visaCategory;

  VisaCategoryValidityType({
    required this.id,
    required this.price,
    required this.visaCategory,
  });

  factory VisaCategoryValidityType.fromJson(Map<String, dynamic> json) =>
      VisaCategoryValidityType(
        id: json["id"],
        price: json["price"],
        visaCategory: AbroadCountry.fromJson(json["visa_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "visa_category": visaCategory.toJson(),
      };
}
