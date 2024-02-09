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

  Application({
    required this.applicationNo,
    required this.createdAt,
    required this.citizen,
    this.passportRenewalType,
  });

  factory Application.fromMap(Map<String, dynamic> json) {
    return Application(
      applicationNo: json["application_no"],
      createdAt: json["created_at"],
      citizen: Citizen.fromMap(json["citizen"]),
      passportRenewalType: json["passport_renewal_type"] == null
          ? null
          : PassportRenewalType.fromMap(json["passport_renewal_type"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "application_no": applicationNo,
        "created_at": createdAt,
        "citizen": citizen.toMap(),
        "origin_id_renewal_type": passportRenewalType?.toMap(),
      };
}

class Citizen {
  String firstName;
  String fatherName;
  String grandFatherName;
  NameJson fatherNameJson;
  NameJson firstNameJson;
  NameJson grandFatherNameJson;
  BirthCountry birthCountry;

  Citizen({
    required this.firstName,
    required this.fatherName,
    required this.grandFatherName,
    required this.fatherNameJson,
    required this.firstNameJson,
    required this.grandFatherNameJson,
    required this.birthCountry,
  });

  factory Citizen.fromMap(Map<String, dynamic> json) => Citizen(
        firstName: json["first_name"],
        fatherName: json["father_name"],
        grandFatherName: json["grand_father_name"],
        fatherNameJson: NameJson.fromMap(json["father_name_json"]),
        firstNameJson: NameJson.fromMap(json["first_name_json"]),
        grandFatherNameJson: NameJson.fromMap(json["grand_father_name_json"]),
        birthCountry: BirthCountry.fromMap(json["birth_country"]),
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "father_name": fatherName,
        "grand_father_name": grandFatherName,
        "father_name_json": fatherNameJson.toMap(),
        "first_name_json": firstNameJson.toMap(),
        "grand_father_name_json": grandFatherNameJson.toMap(),
        "birth_country": birthCountry.toMap(),
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
