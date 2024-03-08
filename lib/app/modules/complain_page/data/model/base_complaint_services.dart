class BaseComplaintService {
  String id;
  String name;
  String description;
  List<ComplaintType> complaintTypes;

  BaseComplaintService({
    required this.id,
    required this.name,
    required this.description,
    required this.complaintTypes,
  });

  factory BaseComplaintService.fromJson(Map<String, dynamic> json) =>
      BaseComplaintService(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        complaintTypes: List<ComplaintType>.from(
            json["complaint_types"].map((x) => ComplaintType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "complaint_types":
            List<dynamic>.from(complaintTypes.map((x) => x.toJson())),
      };
}

class ComplaintType {
  String name;
  String id;

  ComplaintType({
    required this.name,
    required this.id,
  });

  factory ComplaintType.fromJson(Map<String, dynamic> json) => ComplaintType(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class BaseCountryModel {
  String id;
  String name;

  BaseCountryModel({
    required this.id,
    required this.name,
  });

  factory BaseCountryModel.fromJson(Map<String, dynamic> json) =>
      BaseCountryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
