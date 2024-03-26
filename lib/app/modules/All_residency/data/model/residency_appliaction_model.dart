class IcsResidencyApplication {
  String id;
  AbroadCountry occupation;
  String phoneNumber;
  String gender;
  DateTime createdAt;
  DateTime passportExpiryDate;
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

  IcsResidencyApplication({
    required this.id,
    required this.occupation,
    required this.phoneNumber,
    required this.gender,
    required this.createdAt,
    required this.passportExpiryDate,
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
  });

  factory IcsResidencyApplication.fromJson(Map<String, dynamic> json) =>
      IcsResidencyApplication(
        id: json["id"],
        occupation: AbroadCountry.fromJson(json["occupation"]),
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        createdAt: DateTime.parse(json["created_at"]),
        passportExpiryDate: DateTime.parse(json["passport_expiry_date"]),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "occupation": occupation.toJson(),
        "phone_number": phoneNumber,
        "gender": gender,
        "created_at": createdAt.toIso8601String(),
        "passport_expiry_date":
            "${passportExpiryDate.year.toString().padLeft(4, '0')}-${passportExpiryDate.month.toString().padLeft(2, '0')}-${passportExpiryDate.day.toString().padLeft(2, '0')}",
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
