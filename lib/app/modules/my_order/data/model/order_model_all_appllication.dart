class IcsApplication {
  String applicationType;
  List<dynamic> citizenFamilies;
  String createdAt;
  String firstName;
  String fatherName;
  String grandFatherName;
  NameJson fatherNameJson;
  NameJson firstNameJson;
  String photo;
  String gender;
  NameJson grandFatherNameJson;
  BirthCountry birthCountry;
  DateTime dateOfBirth;
  String abroadAddress;
  String birthPlace;
  String? eyeColour;
  String? hairColour;
  double? height;
  String id;
  bool isAdopted;
  String maritalStatus;
  String reviewStatus;
  CurrentCountry nationality;
  CurrentCountry? occupation;
  CurrentCountry currentCountry;
  String embassyId;
  String phoneNumber;
  String skinColour;
  List<ApplicationAppointment> applicationAppointments;
  List<ApplicationDocument> applicationDocuments;
  List<NewOriginIdApplication> newOriginIdApplications;
  List<NewPassportApplication> newPassportApplications;
  List<RenewPassportApplication> renewPassportApplications;
  List<RenewalOriginIdApplication> renewalOriginIdApplications;

  IcsApplication({
    required this.applicationType,
    required this.citizenFamilies,
    required this.createdAt,
    required this.firstName,
    required this.fatherName,
    required this.grandFatherName,
    required this.fatherNameJson,
    required this.firstNameJson,
    required this.photo,
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
    required this.reviewStatus,
    required this.nationality,
    required this.occupation,
    required this.currentCountry,
    required this.embassyId,
    required this.phoneNumber,
    required this.skinColour,
    required this.applicationAppointments,
    required this.applicationDocuments,
    required this.newOriginIdApplications,
    required this.newPassportApplications,
    required this.renewPassportApplications,
    required this.renewalOriginIdApplications,
  });

  factory IcsApplication.fromMap(Map<String, dynamic> json) => IcsApplication(
        applicationType: json["application_type"],
        citizenFamilies:
            List<dynamic>.from(json["citizen_families"].map((x) => x)),
        createdAt: json["created_at"],
        firstName: json["first_name"],
        fatherName: json["father_name"],
        grandFatherName: json["grand_father_name"],
        fatherNameJson: NameJson.fromMap(json["father_name_json"]),
        firstNameJson: NameJson.fromMap(json["first_name_json"]),
        photo: json["photo"],
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
        reviewStatus: json["review_status"],
        nationality: CurrentCountry.fromMap(json["nationality"]),
        occupation: json["occupation"] == null
            ? null
            : CurrentCountry.fromMap(json["occupation"]),
        currentCountry: CurrentCountry.fromMap(json["current_country"]),
        embassyId: json["embassy_id"],
        phoneNumber: json["phone_number"],
        skinColour: json["skin_colour"],
        applicationAppointments: List<ApplicationAppointment>.from(
            json["application_appointments"]
                .map((x) => ApplicationAppointment.fromMap(x))),
        applicationDocuments: List<ApplicationDocument>.from(
            json["application_documents"]
                .map((x) => ApplicationDocument.fromMap(x))),
        newOriginIdApplications: List<NewOriginIdApplication>.from(
            json["new_origin_id_applications"]
                .map((x) => NewOriginIdApplication.fromMap(x))),
        newPassportApplications: List<NewPassportApplication>.from(
            json["new_passport_applications"]
                .map((x) => NewPassportApplication.fromMap(x))),
        renewPassportApplications: List<RenewPassportApplication>.from(
            json["renew_passport_applications"]
                .map((x) => RenewPassportApplication.fromMap(x))),
        renewalOriginIdApplications: List<RenewalOriginIdApplication>.from(
            json["renewal_origin_id_applications"]
                .map((x) => RenewalOriginIdApplication.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "application_type": applicationType,
        "citizen_families": List<dynamic>.from(citizenFamilies.map((x) => x)),
        "created_at": createdAt,
        "first_name": firstName,
        "father_name": fatherName,
        "grand_father_name": grandFatherName,
        "father_name_json": fatherNameJson.toMap(),
        "first_name_json": firstNameJson.toMap(),
        "photo": photo,
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
        "review_status": reviewStatus,
        "nationality": nationality.toMap(),
        "occupation": occupation?.toMap(),
        "current_country": currentCountry.toMap(),
        "embassy_id": embassyId,
        "phone_number": phoneNumber,
        "skin_colour": skinColour,
        "application_appointments":
            List<dynamic>.from(applicationAppointments.map((x) => x.toMap())),
        "application_documents":
            List<dynamic>.from(applicationDocuments.map((x) => x.toMap())),
        "new_origin_id_applications":
            List<dynamic>.from(newOriginIdApplications.map((x) => x.toMap())),
        "new_passport_applications":
            List<dynamic>.from(newPassportApplications.map((x) => x.toMap())),
        "renew_passport_applications":
            List<dynamic>.from(renewPassportApplications.map((x) => x.toMap())),
        "renewal_origin_id_applications": List<dynamic>.from(
            renewalOriginIdApplications.map((x) => x.toMap())),
      };
}

class ApplicationAppointment {
  DateTime date;
  String startTime;
  bool rescheduled;

  ApplicationAppointment({
    required this.date,
    required this.startTime,
    required this.rescheduled,
  });

  factory ApplicationAppointment.fromMap(Map<String, dynamic> json) =>
      ApplicationAppointment(
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"],
        rescheduled: json["rescheduled"],
      );

  Map<String, dynamic> toMap() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "rescheduled": rescheduled,
      };
}

class ApplicationDocument {
  String documentStatus;
  CurrentCountry documentType;
  String? rejectionReason;
  Files files;
  dynamic rejected;
  String id;

  ApplicationDocument({
    required this.documentStatus,
    required this.documentType,
    required this.rejectionReason,
    required this.files,
    required this.rejected,
    required this.id,
  });

  factory ApplicationDocument.fromMap(Map<String, dynamic> json) =>
      ApplicationDocument(
        documentStatus: json["document_status"],
        rejectionReason: json["rejection_reason"],
        documentType: CurrentCountry.fromMap(json["document_type"]),
        files: Files.fromMap(json["files"]),
        rejected: json["rejected"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "document_status": documentStatus,
        "document_type": documentType.toMap(),
        "rejection_reason": rejectionReason,
        "files": files.toMap(),
        "rejected": rejected,
        "id": id,
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

class NewOriginIdApplication {
  String createdAt;
  String applicationNo;
  String applicationId;
  DateTime currentPassportExpiryDate;
  DateTime currentPassportIssuedDate;
  String currentPassportNumber;
  dynamic etPassportExpiryDate;
  String visaNumber;
  dynamic signature;
  CurrentCountry visaType;

  NewOriginIdApplication({
    required this.createdAt,
    required this.applicationNo,
    required this.applicationId,
    required this.currentPassportExpiryDate,
    required this.currentPassportIssuedDate,
    required this.currentPassportNumber,
    required this.etPassportExpiryDate,
    required this.visaNumber,
    required this.signature,
    required this.visaType,
  });

  factory NewOriginIdApplication.fromMap(Map<String, dynamic> json) =>
      NewOriginIdApplication(
        createdAt: json["created_at"],
        applicationNo: json["application_no"],
        applicationId: json["application_id"],
        currentPassportExpiryDate:
            DateTime.parse(json["current_passport_expiry_date"]),
        currentPassportIssuedDate:
            DateTime.parse(json["current_passport_issued_date"]),
        currentPassportNumber: json["current_passport_number"],
        etPassportExpiryDate: json["et_passport_expiry_date"],
        visaNumber: json["visa_number"],
        signature: json["signature"],
        visaType: CurrentCountry.fromMap(json["visa_type"]),
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt,
        "application_no": applicationNo,
        "application_id": applicationId,
        "current_passport_expiry_date":
            "${currentPassportExpiryDate.year.toString().padLeft(4, '0')}-${currentPassportExpiryDate.month.toString().padLeft(2, '0')}-${currentPassportExpiryDate.day.toString().padLeft(2, '0')}",
        "current_passport_issued_date":
            "${currentPassportIssuedDate.year.toString().padLeft(4, '0')}-${currentPassportIssuedDate.month.toString().padLeft(2, '0')}-${currentPassportIssuedDate.day.toString().padLeft(2, '0')}",
        "current_passport_number": currentPassportNumber,
        "et_passport_expiry_date": etPassportExpiryDate,
        "visa_number": visaNumber,
        "signature": signature,
        "visa_type": visaType.toMap(),
      };
}

class NewPassportApplication {
  String createdAt;
  String applicationNo;

  NewPassportApplication({
    required this.createdAt,
    required this.applicationNo,
  });

  factory NewPassportApplication.fromMap(Map<String, dynamic> json) =>
      NewPassportApplication(
        createdAt: json["created_at"],
        applicationNo: json["application_no"],
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt,
        "application_no": applicationNo,
      };
}

class RenewPassportApplication {
  String passportNumber;
  String applicationNo;
  dynamic correctionType;
  CurrentCountry passportRenewalType;
  String id;

  RenewPassportApplication({
    required this.passportNumber,
    required this.applicationNo,
    required this.correctionType,
    required this.passportRenewalType,
    required this.id,
  });

  factory RenewPassportApplication.fromMap(Map<String, dynamic> json) =>
      RenewPassportApplication(
        passportNumber: json["passport_number"],
        applicationNo: json["application_no"],
        correctionType: json["correction_type"],
        passportRenewalType:
            CurrentCountry.fromMap(json["passport_renewal_type"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "passport_number": passportNumber,
        "application_no": applicationNo,
        "correction_type": correctionType,
        "passport_renewal_type": passportRenewalType.toMap(),
        "id": id,
      };
}

class RenewalOriginIdApplication {
  CurrentCountry originIdRenewalType;
  String applicationNo;
  String createdAt;
  String currentPassportNumber;
  String visaNumber;
  CurrentCountry visaType;
  DateTime currentPassportExpiryDate;
  DateTime currentPassportIssuedDate;
  DateTime visaExpiryDate;
  DateTime visaIssuedDate;
  String originIdNumber;

  RenewalOriginIdApplication({
    required this.originIdRenewalType,
    required this.applicationNo,
    required this.createdAt,
    required this.currentPassportNumber,
    required this.visaNumber,
    required this.visaType,
    required this.currentPassportExpiryDate,
    required this.currentPassportIssuedDate,
    required this.visaExpiryDate,
    required this.visaIssuedDate,
    required this.originIdNumber,
  });

  factory RenewalOriginIdApplication.fromMap(Map<String, dynamic> json) =>
      RenewalOriginIdApplication(
        originIdRenewalType:
            CurrentCountry.fromMap(json["origin_id_renewal_type"]),
        applicationNo: json["application_no"],
        createdAt: json["created_at"],
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
      );

  Map<String, dynamic> toMap() => {
        "origin_id_renewal_type": originIdRenewalType.toMap(),
        "application_no": applicationNo,
        "created_at": createdAt,
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
      };
}
