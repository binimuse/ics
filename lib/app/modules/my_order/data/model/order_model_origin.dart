class IcsAllOriginIdApplication {
  String? newId;
  String? renewalId;
  String createdAt;
  IcsAllOriginIdApplicationRenewApplication? renewApplication;
  IcsAllOriginIdApplicationNewApplication? newApplication;

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
            : IcsAllOriginIdApplicationRenewApplication.fromMap(
                json["renew_application"]),
        newApplication: json["new_application"] == null
            ? null
            : IcsAllOriginIdApplicationNewApplication.fromMap(
                json["new_application"]),
      );

  Map<String, dynamic> toMap() => {
        "new_id": newId,
        "renewal_id": renewalId,
        "created_at": createdAt,
        "renew_application": renewApplication?.toMap(),
        "new_application": newApplication?.toMap(),
      };
}

class IcsAllOriginIdApplicationNewApplication {
  String applicationNo;
  String createdAt;
  Citizen citizen;
  CurrentCountry currentCountry;
  String currentPassportNumber;
  String visaNumber;
  CurrentCountry visaType;
  DateTime currentPassportExpiryDate;
  DateTime currentPassportIssuedDate;
  List<Document> newOriginIdDocuments;

  IcsAllOriginIdApplicationNewApplication({
    required this.applicationNo,
    required this.createdAt,
    required this.citizen,
    required this.currentCountry,
    required this.currentPassportNumber,
    required this.visaNumber,
    required this.visaType,
    required this.currentPassportExpiryDate,
    required this.currentPassportIssuedDate,
    required this.newOriginIdDocuments,
  });

  factory IcsAllOriginIdApplicationNewApplication.fromMap(
          Map<String, dynamic> json) =>
      IcsAllOriginIdApplicationNewApplication(
        applicationNo: json["application_no"],
        createdAt: json["created_at"],
        citizen: Citizen.fromMap(json["citizen"]),
        currentCountry: CurrentCountry.fromMap(json["current_country"]),
        currentPassportNumber: json["current_passport_number"],
        visaNumber: json["visa_number"],
        visaType: CurrentCountry.fromMap(json["visa_type"]),
        currentPassportExpiryDate:
            DateTime.parse(json["current_passport_expiry_date"]),
        currentPassportIssuedDate:
            DateTime.parse(json["current_passport_issued_date"]),
        newOriginIdDocuments: List<Document>.from(
            json["new_origin_id_documents"].map((x) => Document.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "application_no": applicationNo,
        "created_at": createdAt,
        "citizen": citizen.toMap(),
        "current_country": currentCountry.toMap(),
        "current_passport_number": currentPassportNumber,
        "visa_number": visaNumber,
        "visa_type": visaType.toMap(),
        "current_passport_expiry_date":
            "${currentPassportExpiryDate.year.toString().padLeft(4, '0')}-${currentPassportExpiryDate.month.toString().padLeft(2, '0')}-${currentPassportExpiryDate.day.toString().padLeft(2, '0')}",
        "current_passport_issued_date":
            "${currentPassportIssuedDate.year.toString().padLeft(4, '0')}-${currentPassportIssuedDate.month.toString().padLeft(2, '0')}-${currentPassportIssuedDate.day.toString().padLeft(2, '0')}",
        "new_origin_id_documents":
            List<dynamic>.from(newOriginIdDocuments.map((x) => x.toMap())),
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
  CurrentCountry nationality;
  CurrentCountry occupation;
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
        fatherNameJson: NameJson.fromMap(json["father_name_json"]),
        firstNameJson: NameJson.fromMap(json["first_name_json"]),
        gender: json["gender"],
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
        nationality: CurrentCountry.fromMap(json["nationality"]),
        occupation: CurrentCountry.fromMap(json["occupation"]),
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

class CurrentCountry {
  String id;
  String name;

  CurrentCountry({
    required this.id,
    required this.name,
  });

  factory CurrentCountry.fromMap(Map<String, dynamic> json) => CurrentCountry(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Document {
  CurrentCountry documentType;
  Files files;

  Document({
    required this.documentType,
    required this.files,
  });

  factory Document.fromMap(Map<String, dynamic> json) => Document(
        documentType: CurrentCountry.fromMap(json["document_type"]),
        files: Files.fromMap(json["files"]),
      );

  Map<String, dynamic> toMap() => {
        "document_type": documentType.toMap(),
        "files": files.toMap(),
      };
}

class Files {
  String path;

  Files({
    required this.path,
  });

  factory Files.fromMap(Map<String, dynamic> json) => Files(
        path: json["path"],
      );

  Map<String, dynamic> toMap() => {
        "path": path,
      };
}

class IcsAllOriginIdApplicationRenewApplication {
  CurrentCountry originIdRenewalType;
  String applicationNo;
  String createdAt;
  Citizen citizen;
  CurrentCountry currentCountry;
  String currentPassportNumber;
  String visaNumber;
  CurrentCountry visaType;
  DateTime currentPassportExpiryDate;
  DateTime currentPassportIssuedDate;
  DateTime visaExpiryDate;
  DateTime visaIssuedDate;
  String originIdNumber;
  List<Document> renewOriginIdDocuments;

  IcsAllOriginIdApplicationRenewApplication({
    required this.originIdRenewalType,
    required this.applicationNo,
    required this.createdAt,
    required this.citizen,
    required this.currentCountry,
    required this.currentPassportNumber,
    required this.visaNumber,
    required this.visaType,
    required this.currentPassportExpiryDate,
    required this.currentPassportIssuedDate,
    required this.visaExpiryDate,
    required this.visaIssuedDate,
    required this.originIdNumber,
    required this.renewOriginIdDocuments,
  });

  factory IcsAllOriginIdApplicationRenewApplication.fromMap(
          Map<String, dynamic> json) =>
      IcsAllOriginIdApplicationRenewApplication(
        originIdRenewalType:
            CurrentCountry.fromMap(json["origin_id_renewal_type"]),
        applicationNo: json["application_no"],
        createdAt: json["created_at"],
        citizen: Citizen.fromMap(json["citizen"]),
        currentCountry: CurrentCountry.fromMap(json["current_country"]),
        currentPassportNumber: json["current_passport_number"],
        visaNumber: json["visa_number"],
        visaType: CurrentCountry.fromMap(json["visa_type"]),
        currentPassportExpiryDate:
            DateTime.parse(json["current_passport_expiry_date"]),
        currentPassportIssuedDate:
            DateTime.parse(json["current_passport_issued_date"]),
        visaExpiryDate: DateTime.parse(json["visa_expiry_date"]),
        visaIssuedDate: DateTime.parse(json["visa_issued_date"]),
        originIdNumber: json["origin_id_number"],
        renewOriginIdDocuments: List<Document>.from(
            json["renew_origin_id_documents"].map((x) => Document.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "origin_id_renewal_type": originIdRenewalType.toMap(),
        "application_no": applicationNo,
        "created_at": createdAt,
        "citizen": citizen.toMap(),
        "current_country": currentCountry.toMap(),
        "current_passport_number": currentPassportNumber,
        "visa_number": visaNumber,
        "visa_type": visaType.toMap(),
        "current_passport_expiry_date":
            "${currentPassportExpiryDate.year.toString().padLeft(4, '0')}-${currentPassportExpiryDate.month.toString().padLeft(2, '0')}-${currentPassportExpiryDate.day.toString().padLeft(2, '0')}",
        "current_passport_issued_date":
            "${currentPassportIssuedDate.year.toString().padLeft(4, '0')}-${currentPassportIssuedDate.month.toString().padLeft(2, '0')}-${currentPassportIssuedDate.day.toString().padLeft(2, '0')}",
        "visa_expiry_date":
            "${visaExpiryDate.year.toString().padLeft(4, '0')}-${visaExpiryDate.month.toString().padLeft(2, '0')}-${visaExpiryDate.day.toString().padLeft(2, '0')}",
        "visa_issued_date":
            "${visaIssuedDate.year.toString().padLeft(4, '0')}-${visaIssuedDate.month.toString().padLeft(2, '0')}-${visaIssuedDate.day.toString().padLeft(2, '0')}",
        "origin_id_number": originIdNumber,
        "renew_origin_id_documents":
            List<dynamic>.from(renewOriginIdDocuments.map((x) => x.toMap())),
      };
}
