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
