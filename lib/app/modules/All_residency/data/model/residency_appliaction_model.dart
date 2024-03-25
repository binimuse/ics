
class IcsResidencyApplication {
    String id;
    Country occupation;
    String phoneNumber;
    DateTime createdAt;
    DateTime passportExpiryDate;
    DateTime passportIssuedDate;
    String passportNumber;
    String emailAddress;
    String fatherName;
    String firstName;
    String grandFatherName;
    dynamic kebele;
    String localAddress;
    String visaNumber;
    String visaReferenceNo;
    DateTime visaWorkpermitIssuedDate;
    dynamic woreda;
    String zoneSubcity;
    Country nationality;
    Country country;
    Country embassy;
    ResidencyType residencyType;
    Country region;

    IcsResidencyApplication({
        required this.id,
        required this.occupation,
        required this.phoneNumber,
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
        required this.country,
        required this.embassy,
        required this.residencyType,
        required this.region,
    });

    factory IcsResidencyApplication.fromJson(Map<String, dynamic> json) => IcsResidencyApplication(
        id: json["id"],
        occupation: Country.fromJson(json["occupation"]),
        phoneNumber: json["phone_number"],
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
        visaWorkpermitIssuedDate: DateTime.parse(json["visa_workpermit_issued_date"]),
        woreda: json["woreda"],
        zoneSubcity: json["zone_subcity"],
        nationality: Country.fromJson(json["nationality"]),
        country: Country.fromJson(json["country"]),
        embassy: Country.fromJson(json["embassy"]),
        residencyType: ResidencyType.fromJson(json["residency_type"]),
        region: Country.fromJson(json["region"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "occupation": occupation.toJson(),
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "passport_expiry_date": "${passportExpiryDate.year.toString().padLeft(4, '0')}-${passportExpiryDate.month.toString().padLeft(2, '0')}-${passportExpiryDate.day.toString().padLeft(2, '0')}",
        "passport_issued_date": "${passportIssuedDate.year.toString().padLeft(4, '0')}-${passportIssuedDate.month.toString().padLeft(2, '0')}-${passportIssuedDate.day.toString().padLeft(2, '0')}",
        "passport_number": passportNumber,
        "email_address": emailAddress,
        "father_name": fatherName,
        "first_name": firstName,
        "grand_father_name": grandFatherName,
        "kebele": kebele,
        "local_address": localAddress,
        "visa_number": visaNumber,
        "visa_reference_no": visaReferenceNo,
        "visa_workpermit_issued_date": "${visaWorkpermitIssuedDate.year.toString().padLeft(4, '0')}-${visaWorkpermitIssuedDate.month.toString().padLeft(2, '0')}-${visaWorkpermitIssuedDate.day.toString().padLeft(2, '0')}",
        "woreda": woreda,
        "zone_subcity": zoneSubcity,
        "nationality": nationality.toJson(),
        "country": country.toJson(),
        "embassy": embassy.toJson(),
        "residency_type": residencyType.toJson(),
        "region": region.toJson(),
    };
}

class Country {
    String id;
    String name;

    Country({
        required this.id,
        required this.name,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
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
