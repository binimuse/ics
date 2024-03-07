class GetUrlModel {
  String? path;
  String? url;

  GetUrlModel({
    this.path,
    this.url,
  });

  factory GetUrlModel.fromJson(Map<String, dynamic> json) {
    return GetUrlModel(
      path: json['path'],
      url: json['url'],
    );
  }
}

class DocPathModel {
  String? path;
  String? docTypeId;

  DocPathModel({
    this.path,
    this.docTypeId,
  });

  Map<String, dynamic> toJson() => {
        "files": {"path": path},
        "document_type_id": docTypeId,
      };
}
