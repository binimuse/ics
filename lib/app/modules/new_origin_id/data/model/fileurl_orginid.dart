class GetUrlModelOrginid {
  String? path;
  String? url;

  GetUrlModelOrginid({
    this.path,
    this.url,
  });

  factory GetUrlModelOrginid.fromJson(Map<String, dynamic> json) {
    return GetUrlModelOrginid(
      path: json['path'],
      url: json['url'],
    );
  }
}
