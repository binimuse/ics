class GetUrlModelRenewOrginid {
  String? path;
  String? url;

  GetUrlModelRenewOrginid({
    this.path,
    this.url,
  });

  factory GetUrlModelRenewOrginid.fromJson(Map<String, dynamic> json) {
    return GetUrlModelRenewOrginid(
      path: json['path'],
      url: json['url'],
    );
  }
}
