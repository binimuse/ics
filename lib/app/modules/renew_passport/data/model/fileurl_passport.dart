class GetUrlModelRenewPassport {
  String? path;
  String? url;

  GetUrlModelRenewPassport({
    this.path,
    this.url,
  });

  factory GetUrlModelRenewPassport.fromJson(Map<String, dynamic> json) {
    return GetUrlModelRenewPassport(
      path: json['path'],
      url: json['url'],
    );
  }
}
