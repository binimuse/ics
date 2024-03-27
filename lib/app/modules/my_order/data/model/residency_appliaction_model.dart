import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';

class ResidencyModel {
  String id;
  String phoneNumber;
  DateTime createdAt;
  String reviewStatus;
  DateTime passportExpiryDate;
  String gender;
  DateTime passportIssuedDate;
  String passportNumber;
  String emailAddress;
  String fatherName;
  String firstName;
  String grandFatherName;
  String kebele;
  String localAddress;
  String visaNumber;
  String visaReferenceNo;
  DateTime visaWorkpermitIssuedDate;
  String woreda;
  String zoneSubcity;
  AbroadCountry nationality;
  AbroadCountry embassy;
  ResidencyType residencyType;
  AbroadCountry region;
  AbroadCountry abroadCountry;
  List<ResidencyApplicationDocument> residencyApplicationDocuments;
  ResidencyApplicationUrgencyLevel? residencyApplicationUrgencyLevel;
  AbroadCountry occupation;

  ResidencyModel({
    required this.id,
    required this.phoneNumber,
    required this.createdAt,
    required this.reviewStatus,
    required this.passportExpiryDate,
    required this.gender,
    required this.passportIssuedDate,
    required this.passportNumber,
    required this.emailAddress,
    required this.fatherName,
    required this.firstName,
    required this.grandFatherName,
    required this.kebele,
    required this.localAddress,
    required this.visaNumber,
    required this.visaReferenceNo,
    required this.visaWorkpermitIssuedDate,
    required this.woreda,
    required this.zoneSubcity,
    required this.nationality,
    required this.embassy,
    required this.residencyType,
    required this.region,
    required this.abroadCountry,
    required this.residencyApplicationDocuments,
    required this.residencyApplicationUrgencyLevel,
    required this.occupation,
  });

  factory ResidencyModel.fromJson(Map<String, dynamic> json) => ResidencyModel(
        id: json["id"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        reviewStatus: json["review_status"],
        passportExpiryDate: DateTime.parse(json["passport_expiry_date"]),
        gender: json["gender"],
        passportIssuedDate: DateTime.parse(json["passport_issued_date"]),
        passportNumber: json["passport_number"],
        emailAddress: json["email_address"],
        fatherName: json["father_name"],
        firstName: json["first_name"],
        grandFatherName: json["grand_father_name"],
        kebele: json["kebele"],
        localAddress: json["local_address"],
        visaNumber: json["visa_number"],
        visaReferenceNo: json["visa_reference_no"],
        visaWorkpermitIssuedDate:
            DateTime.parse(json["visa_workpermit_issued_date"]),
        woreda: json["woreda"],
        zoneSubcity: json["zone_subcity"],
        nationality: AbroadCountry.fromJson(json["nationality"]),
        embassy: AbroadCountry.fromJson(json["embassy"]),
        residencyType: ResidencyType.fromJson(json["residency_type"]),
        region: AbroadCountry.fromJson(json["region"]),
        abroadCountry: AbroadCountry.fromJson(json["abroad_country"]),
        residencyApplicationDocuments: List<ResidencyApplicationDocument>.from(
            json["residency_application_documents"]
                .map((x) => ResidencyApplicationDocument.fromJson(x))),
        residencyApplicationUrgencyLevel:
            json["residency_application_urgency_level"] == null
                ? null
                : ResidencyApplicationUrgencyLevel.fromJson(
                    json["residency_application_urgency_level"]),
        occupation: AbroadCountry.fromJson(json["occupation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "review_status": reviewStatus,
        "passport_expiry_date":
            "${passportExpiryDate.year.toString().padLeft(4, '0')}-${passportExpiryDate.month.toString().padLeft(2, '0')}-${passportExpiryDate.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "passport_issued_date":
            "${passportIssuedDate.year.toString().padLeft(4, '0')}-${passportIssuedDate.month.toString().padLeft(2, '0')}-${passportIssuedDate.day.toString().padLeft(2, '0')}",
        "passport_number": passportNumber,
        "email_address": emailAddress,
        "father_name": fatherName,
        "first_name": firstName,
        "grand_father_name": grandFatherName,
        "kebele": kebele,
        "local_address": localAddress,
        "visa_number": visaNumber,
        "visa_reference_no": visaReferenceNo,
        "visa_workpermit_issued_date":
            "${visaWorkpermitIssuedDate.year.toString().padLeft(4, '0')}-${visaWorkpermitIssuedDate.month.toString().padLeft(2, '0')}-${visaWorkpermitIssuedDate.day.toString().padLeft(2, '0')}",
        "woreda": woreda,
        "zone_subcity": zoneSubcity,
        "nationality": nationality.toJson(),
        "embassy": embassy.toJson(),
        "residency_type": residencyType.toJson(),
        "region": region.toJson(),
        "abroad_country": abroadCountry.toJson(),
        "residency_application_documents": List<dynamic>.from(
            residencyApplicationDocuments.map((x) => x.toJson())),
        "residency_application_urgency_level":
            residencyApplicationUrgencyLevel?.toJson(),
        "occupation": occupation.toJson(),
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

class ResidencyApplicationDocument {
  Files files;
  String documentStatus;
  dynamic rejecterNote;
  DateTime createdAt;
  CurrentCountry documentType;
  String id;

  ResidencyApplicationDocument({
    required this.files,
    required this.documentStatus,
    required this.rejecterNote,
    required this.createdAt,
    required this.documentType,
    required this.id,
  });

  factory ResidencyApplicationDocument.fromJson(Map<String, dynamic> json) =>
      ResidencyApplicationDocument(
        files: Files.fromJson(json["files"]),
        documentStatus: json["document_status"],
        rejecterNote: json["rejecter_note"],
        createdAt: DateTime.parse(json["created_at"]),
        documentType: CurrentCountry.fromMap(json["document_type"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "files": files.toJson(),
        "document_status": documentStatus,
        "created_at": createdAt.toIso8601String(),
        "rejecter_note": rejecterNote,
        "document_type": documentType.toMap(),
        "id": id,
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

class ResidencyApplicationUrgencyLevel {
  String id;
  String name;
  int price;

  ResidencyApplicationUrgencyLevel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ResidencyApplicationUrgencyLevel.fromJson(
          Map<String, dynamic> json) =>
      ResidencyApplicationUrgencyLevel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}

class ResidencyType {
  String name;

  ResidencyType({
    required this.name,
  });

  factory ResidencyType.fromJson(Map<String, dynamic> json) => ResidencyType(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
