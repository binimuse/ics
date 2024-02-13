class IcsAllPassportIdApplication {
  String? newId;
  String? renew_id;
  String createdAt;
  Application? renewApplication;
  Application? newApplication;

  IcsAllPassportIdApplication({
    required this.newId,
    required this.renew_id,
    required this.createdAt,
    required this.renewApplication,
    required this.newApplication,
  });

  factory IcsAllPassportIdApplication.fromMap(Map<String, dynamic> json) =>
      IcsAllPassportIdApplication(
        newId: json["new_id"],
        renew_id: json["renew_id"],
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
        "renew_id": renew_id,
        "created_at": createdAt,
        "renew_application": renewApplication?.toMap(),
        "new_application": newApplication?.toMap(),
      };
}

class Application {
  String applicationNo;
  String createdAt;
  Citizen citizen;
  PassportRenewalType? passportRenewalType;
  CommonType? currentCountry;
  String? passport_number;
  String? visaNumber;

  DateTime? currentPassportExpiryDate;
  DateTime? currentPassportIssuedDate;

  Application({
    required this.applicationNo,
    required this.createdAt,
    required this.citizen,
    this.passportRenewalType,
    required this.currentCountry,
    this.passport_number,
    this.visaNumber,
  });

  factory Application.fromMap(Map<String, dynamic> json) {
    return Application(
      applicationNo: json["application_no"],
      passport_number: json["passport_number"],
      createdAt: json["created_at"],
      citizen: Citizen.fromMap(json["citizen"]),
      currentCountry: CommonType.fromMap(json["current_country"]),
      passportRenewalType: json["passport_renewal_type"] == null
          ? null
          : PassportRenewalType.fromMap(json["passport_renewal_type"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "application_no": applicationNo,
        "created_at": createdAt,
        "citizen": citizen.toMap(),
        "passport_number": passport_number,
        "origin_id_renewal_type": passportRenewalType?.toMap(),
        "current_country": currentCountry!.toMap(),
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

class PassportRenewalType {
  String id;
  String name;

  PassportRenewalType({
    required this.id,
    required this.name,
  });

  factory PassportRenewalType.fromMap(Map<String, dynamic> json) {
    print(json);
    return PassportRenewalType(
      id: json["id"],
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
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
