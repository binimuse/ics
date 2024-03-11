class IcsServiceComplaintModel {
  String id;
  DateTime createdAt;
  ComplaintType complaintType;
  ComplaintService? embassy;
  dynamic files;
  String message;
  int rating;
  dynamic resolved;
  dynamic resolvedAt;
  dynamic resolverNote;

  IcsServiceComplaintModel({
    required this.id,
    required this.createdAt,
    required this.complaintType,
    required this.embassy,
    required this.files,
    required this.message,
    required this.rating,
    required this.resolved,
    required this.resolvedAt,
    required this.resolverNote,
  });

  factory IcsServiceComplaintModel.fromJson(Map<String, dynamic> json) =>
      IcsServiceComplaintModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        complaintType: ComplaintType.fromJson(json["complaint_type"]),
        embassy: json["embassy"] == null
            ? null
            : ComplaintService.fromJson(json["embassy"]),
        files: json["files"],
        message: json["message"],
        rating: json["rating"],
        resolved: json["resolved"],
        resolvedAt: json["resolved_at"],
        resolverNote: json["resolver_note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "complaint_type": complaintType.toJson(),
        "embassy": embassy?.toJson(),
        "files": files,
        "message": message,
        "rating": rating,
        "resolved": resolved,
        "resolved_at": resolvedAt,
        "resolver_note": resolverNote,
      };
}

class ComplaintType {
  String id;
  String name;
  ComplaintService complaintService;

  ComplaintType({
    required this.id,
    required this.name,
    required this.complaintService,
  });

  factory ComplaintType.fromJson(Map<String, dynamic> json) => ComplaintType(
        id: json["id"],
        name: json["name"],
        complaintService: ComplaintService.fromJson(json["complaint_service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "complaint_service": complaintService.toJson(),
      };
}

class ComplaintService {
  String id;
  String name;

  ComplaintService({
    required this.id,
    required this.name,
  });

  factory ComplaintService.fromJson(Map<String, dynamic> json) =>
      ComplaintService(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class FileElement {
  String? name;
  String? path;
  FileFiles? files;
  String? documentTypeId;

  FileElement({
    this.name,
    this.path,
    this.files,
    this.documentTypeId,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        name: json["name"],
        path: json["path"],
        files: json["files"] == null ? null : FileFiles.fromJson(json["files"]),
        documentTypeId: json["document_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
        "files": files?.toJson(),
        "document_type_id": documentTypeId,
      };
}

class FileFiles {
  String path;

  FileFiles({
    required this.path,
  });

  factory FileFiles.fromJson(Map<String, dynamic> json) => FileFiles(
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
      };
}

class FilesFiles {
  String name;
  String path;

  FilesFiles({
    required this.name,
    required this.path,
  });

  factory FilesFiles.fromJson(Map<String, dynamic> json) => FilesFiles(
        name: json["name"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
      };
}
