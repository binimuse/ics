class IcsAllOriginIdApplication {
  String? newId;
  String? renewalId;
  String createdAt;
  Application? renewApplication;
  Application? newApplication;

  IcsAllOriginIdApplication({
    required this.newId,
    required this.renewalId,
    required this.createdAt,
    required this.renewApplication,
    required this.newApplication,
  });

  factory IcsAllOriginIdApplication.fromMap(Map<String, dynamic> json) =>
      IcsAllOriginIdApplication(
        newId: json["new_id"],
        renewalId: json["renewal_id"],
        createdAt: json["created_at"],
        renewApplication: json["renew_application"] == null
            ? null
            : Application.fromMap(json["renew_application"]),
        newApplication: json["new_application"] == null
            ? null
            : Application.fromMap(json["new_application"]),
      );

  Map<String, dynamic> toMap() => {
        "new_id": newId,
        "renewal_id": renewalId,
        "created_at": createdAt,
        "renew_application": renewApplication?.toMap(),
        "new_application": newApplication?.toMap(),
      };
}

class Application {
  String applicationNo;
  String createdAt;
  Citizen citizen;
  CommonType? originIdRenewalType;

  CommonType? currentCountry;
  String? currentPassportNumber;
  String? visaNumber;
  CommonType? visaType;
  DateTime? currentPassportExpiryDate;
  DateTime? currentPassportIssuedDate;
  DateTime? visaExpiryDate;
  DateTime? visaIssuedDate;
  String? originIdNumber;

  Application({
    required this.applicationNo,
    required this.createdAt,
    required this.citizen,
    required this.currentCountry,
    this.currentPassportNumber,
    this.visaNumber,
    this.visaType,
    this.currentPassportExpiryDate,
    this.currentPassportIssuedDate,
    this.originIdRenewalType,
    this.visaExpiryDate,
    this.visaIssuedDate,
    this.originIdNumber,
  });

  factory Application.fromMap(Map<String, dynamic> json) {
    return Application(
      applicationNo: json["application_no"],
      createdAt: json["created_at"],
      citizen: Citizen.fromMap(json["citizen"]),
      currentCountry: CommonType.fromMap(json["current_country"]),
      currentPassportNumber: json["current_passport_number"],
      visaNumber: json["visa_number"],
      visaType: CommonType.fromMap(json["visa_type"]),
      currentPassportExpiryDate:
          DateTime.parse(json["current_passport_expiry_date"]),
      currentPassportIssuedDate:
          DateTime.parse(json["current_passport_issued_date"]),
      originIdRenewalType: json["origin_id_renewal_type"] == null
          ? null
          : CommonType.fromMap(json["origin_id_renewal_type"]),
      visaExpiryDate: json["visa_expiry_date"] != null
          ? DateTime.parse(json["visa_expiry_date"])
          : null,
      visaIssuedDate: json["visa_issued_date"] != null
          ? DateTime.parse(json["visa_issued_date"])
          : null,
      originIdNumber: json["origin_id_number"] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        "application_no": applicationNo,
        "created_at": createdAt,
        "citizen": citizen.toMap(),
        "current_country": currentCountry!.toMap(),
        "current_passport_number": currentPassportNumber,
        "visa_number": visaNumber,
        "visa_type": visaType!.toMap(),
        "current_passport_expiry_date":
            "${currentPassportExpiryDate!.year.toString().padLeft(4, '0')}-${currentPassportExpiryDate!.month.toString().padLeft(2, '0')}-${currentPassportExpiryDate!.day.toString().padLeft(2, '0')}",
        "current_passport_issued_date":
            "${currentPassportIssuedDate!.year.toString().padLeft(4, '0')}-${currentPassportIssuedDate!.month.toString().padLeft(2, '0')}-${currentPassportIssuedDate!.day.toString().padLeft(2, '0')}",
        "origin_id_renewal_type": originIdRenewalType?.toMap(),
        "visa_expiry_date":
            "${visaExpiryDate!.year.toString().padLeft(4, '0')}-${visaExpiryDate!.month.toString().padLeft(2, '0')}-${visaExpiryDate!.day.toString().padLeft(2, '0')}",
        "visa_issued_date":
            "${visaIssuedDate!.year.toString().padLeft(4, '0')}-${visaIssuedDate!.month.toString().padLeft(2, '0')}-${visaIssuedDate!.day.toString().padLeft(2, '0')}",
        "origin_id_number": originIdNumber ?? "",
      };
}

class Citizen {
  String firstName;
  String fatherName;
  String grandFatherName;
  NameJson fatherNameJson;
  NameJson firstNameJson;
  String gender;
  NameJson grandFatherNameJson;
  BirthCountry birthCountry;
  DateTime dateOfBirth;
  String abroadAddress;
  String birthPlace;
  String eyeColour;
  String hairColour;
  double height;
  String id;
  bool isAdopted;
  String maritalStatus;
  Nationality nationality;
  Nationality occupation;
  String phoneNumber;
  dynamic photo;
  String skinColour;

  Citizen({
    required this.firstName,
    required this.fatherName,
    required this.grandFatherName,
    required this.fatherNameJson,
    required this.firstNameJson,
    required this.gender,
    required this.grandFatherNameJson,
    required this.birthCountry,
    required this.dateOfBirth,
    required this.abroadAddress,
    required this.birthPlace,
    required this.eyeColour,
    required this.hairColour,
    required this.height,
    required this.id,
    required this.isAdopted,
    required this.maritalStatus,
    required this.nationality,
    required this.occupation,
    required this.phoneNumber,
    required this.photo,
    required this.skinColour,
  });

  factory Citizen.fromMap(Map<String, dynamic> json) => Citizen(
        firstName: json["first_name"],
        fatherName: json["father_name"],
        grandFatherName: json["grand_father_name"],
        gender: json["gender"],
        fatherNameJson: NameJson.fromMap(json["father_name_json"]),
        firstNameJson: NameJson.fromMap(json["first_name_json"]),
        grandFatherNameJson: NameJson.fromMap(json["grand_father_name_json"]),
        birthCountry: BirthCountry.fromMap(json["birth_country"]),
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        abroadAddress: json["abroad_address"],
        birthPlace: json["birth_place"],
        eyeColour: json["eye_colour"],
        hairColour: json["hair_colour"],
        height: json["height"]?.toDouble(),
        id: json["id"],
        isAdopted: json["is_adopted"],
        maritalStatus: json["marital_status"],
        nationality: Nationality.fromMap(json["nationality"]),
        occupation: Nationality.fromMap(json["occupation"]),
        phoneNumber: json["phone_number"],
        photo: json["photo"],
        skinColour: json["skin_colour"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "father_name": fatherName,
        "grand_father_name": grandFatherName,
        "father_name_json": fatherNameJson.toMap(),
        "first_name_json": firstNameJson.toMap(),
        "gender": gender,
        "grand_father_name_json": grandFatherNameJson.toMap(),
        "birth_country": birthCountry.toMap(),
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "abroad_address": abroadAddress,
        "birth_place": birthPlace,
        "eye_colour": eyeColour,
        "hair_colour": hairColour,
        "height": height,
        "id": id,
        "is_adopted": isAdopted,
        "marital_status": maritalStatus,
        "nationality": nationality.toMap(),
        "occupation": occupation.toMap(),
        "phone_number": phoneNumber,
        "photo": photo,
        "skin_colour": skinColour,
      };
}

class BirthCountry {
  String name;

  BirthCountry({
    required this.name,
  });

  factory BirthCountry.fromMap(Map<String, dynamic> json) => BirthCountry(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class NameJson {
  String am;
  String en;

  NameJson({
    required this.am,
    required this.en,
  });

  factory NameJson.fromMap(Map<String, dynamic> json) => NameJson(
        am: json["am"],
        en: json["en"],
      );

  Map<String, dynamic> toMap() => {
        "am": am,
        "en": en,
      };
}

class Nationality {
  String id;
  String name;

  Nationality({
    required this.id,
    required this.name,
  });

  factory Nationality.fromMap(Map<String, dynamic> json) => Nationality(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class CommonType {
  String id;
  String name;

  CommonType({
    required this.id,
    required this.name,
  });

  factory CommonType.fromMap(Map<String, dynamic> json) {
    print(json);
    return CommonType(
      id: json["id"],
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
