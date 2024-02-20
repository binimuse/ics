import 'package:ics/app/modules/my_order/data/model/order_model_origin.dart';

class IcsAllPassportApplication {
  String? newId;
  String? renewId;
  String createdAt;
  IcsAllPassportApplicationRenewApplication? renewApplication;
  IcsAllPassportApplicationNewApplication? newApplication;

  IcsAllPassportApplication({
    required this.newId,
    required this.renewId,
    required this.createdAt,
    required this.renewApplication,
    required this.newApplication,
  });

  factory IcsAllPassportApplication.fromMap(Map<String, dynamic> json) =>
      IcsAllPassportApplication(
        newId: json["new_id"],
        renewId: json["renew_id"],
        createdAt: json["created_at"],
        renewApplication: json["renew_application"] == null
            ? null
            : IcsAllPassportApplicationRenewApplication.fromMap(
                json["renew_application"]),
        newApplication: json["new_application"] == null
            ? null
            : IcsAllPassportApplicationNewApplication.fromMap(
                json["new_application"]),
      );

  Map<String, dynamic> toMap() => {
        "new_id": newId,
        "renew_id": renewId,
        "created_at": createdAt,
        "renew_application": renewApplication?.toMap(),
        "new_application": newApplication?.toMap(),
      };
}

class IcsAllPassportApplicationNewApplication {
  String reviewStatus;
  String applicationNo;
  String createdAt;
  Citizen citizen;
  CurrentCountry currentCountry;
  List<Appointment> appointments;
  List<Document> newApplicationDocuments;
  String? passport_number;

  IcsAllPassportApplicationNewApplication({
    required this.applicationNo,
    required this.reviewStatus,
    required this.appointments,
    required this.createdAt,
    required this.citizen,
    required this.currentCountry,
    this.passport_number,
    required this.newApplicationDocuments,
  });

  factory IcsAllPassportApplicationNewApplication.fromMap(
          Map<String, dynamic> json) =>
      IcsAllPassportApplicationNewApplication(
        reviewStatus: json["review_status"],
        appointments: List<Appointment>.from(
            json["appointments"].map((x) => Appointment.fromMap(x))),
        applicationNo: json["application_no"],
        passport_number: json["passport_number"],
        createdAt: json["created_at"],
        citizen: Citizen.fromMap(json["citizen"]),
        currentCountry: CurrentCountry.fromMap(json["current_country"]),
        newApplicationDocuments: List<Document>.from(
            json["new_application_documents"].map((x) => Document.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "review_status": reviewStatus,
        "appointments": List<dynamic>.from(appointments.map((x) => x.toMap())),
        "application_no": applicationNo,
        "created_at": createdAt,
        "passport_number": passport_number,
        "citizen": citizen.toMap(),
        "current_country": currentCountry.toMap(),
        "new_application_documents":
            List<dynamic>.from(newApplicationDocuments.map((x) => x.toMap())),
      };
}

class Appointment {
  DateTime date;
  String startTime;
  bool rescheduled;

  Appointment({
    required this.date,
    required this.startTime,
    required this.rescheduled,
  });

  factory Appointment.fromMap(Map<String, dynamic> json) => Appointment(
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

class IcsAllPassportApplicationRenewApplication {
  CurrentCountry passportRenewalType;
  String applicationNo;
  String createdAt;
  Citizen citizen;
  String? passport_number;
  CurrentCountry currentCountry;
  List<Document> renewPassportApplicationDocuments;

  IcsAllPassportApplicationRenewApplication({
    required this.passportRenewalType,
    required this.applicationNo,
    required this.createdAt,
    required this.citizen,
    this.passport_number,
    required this.currentCountry,
    required this.renewPassportApplicationDocuments,
  });

  factory IcsAllPassportApplicationRenewApplication.fromMap(
          Map<String, dynamic> json) =>
      IcsAllPassportApplicationRenewApplication(
        passportRenewalType:
            CurrentCountry.fromMap(json["passport_renewal_type"]),
        applicationNo: json["application_no"],
        createdAt: json["created_at"],
        passport_number: json["passport_number"],
        citizen: Citizen.fromMap(json["citizen"]),
        currentCountry: CurrentCountry.fromMap(json["current_country"]),
        renewPassportApplicationDocuments: List<Document>.from(
            json["renew_passport_application_documents"]
                .map((x) => Document.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "passport_renewal_type": passportRenewalType.toMap(),
        "application_no": applicationNo,
        "created_at": createdAt,
        "citizen": citizen.toMap(),
        "passport_number": passport_number,
        "current_country": currentCountry.toMap(),
        "renew_passport_application_documents": List<dynamic>.from(
            renewPassportApplicationDocuments.map((x) => x.toMap())),
      };
}
