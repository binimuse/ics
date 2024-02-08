
class IcsAllOriginIdApplication {
  dynamic newId;
  String renewalId;
  RenewApplication renewApplication;
  dynamic newApplication;

  IcsAllOriginIdApplication({
    required this.newId,
    required this.renewalId,
    required this.renewApplication,
    required this.newApplication,
  });

  factory IcsAllOriginIdApplication.fromMap(Map<String, dynamic> json) =>
      IcsAllOriginIdApplication(
        newId: json["new_id"],
        renewalId: json["renewal_id"],
        renewApplication: RenewApplication.fromMap(json["renew_application"]),
        newApplication: json["new_application"],
      );

  Map<String, dynamic> toMap() => {
        "new_id": newId,
        "renewal_id": renewalId,
        "renew_application": renewApplication.toMap(),
        "new_application": newApplication,
      };
}

class RenewApplication {
  String applicationNo;
  String createdAt;
  Citizen citizen;

  RenewApplication({
    required this.applicationNo,
    required this.createdAt,
    required this.citizen,
  });

  factory RenewApplication.fromMap(Map<String, dynamic> json) =>
      RenewApplication(
        applicationNo: json["application_no"],
        createdAt: json["created_at"],
        citizen: Citizen.fromMap(json["citizen"]),
      );

  Map<String, dynamic> toMap() => {
        "application_no": applicationNo,
        "created_at": createdAt,
        "citizen": citizen.toMap(),
      };
}

class Citizen {
  String firstName;

  Citizen({
    required this.firstName,
  });

  factory Citizen.fromMap(Map<String, dynamic> json) => Citizen(
        firstName: json["first_name"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
      };
}
