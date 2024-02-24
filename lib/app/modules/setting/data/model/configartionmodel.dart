class BaseSiteConfiguration {
  Contacts? contacts;
  Contacts? faq;
  Contacts? privacyPolicy;
  Contacts? siteAbout;
  Contacts? siteTitle;

  BaseSiteConfiguration({
    this.contacts,
    this.faq,
    this.privacyPolicy,
    this.siteAbout,
    this.siteTitle,
  });

  factory BaseSiteConfiguration.fromMap(Map<String, dynamic> json) =>
      BaseSiteConfiguration(
        contacts: json["contacts"] == null
            ? null
            : Contacts.fromMap(json["contacts"]),
        faq: json["faq"] == null ? null : Contacts.fromMap(json["faq"]),
        privacyPolicy: json["privacy_policy"] == null
            ? null
            : Contacts.fromMap(json["privacy_policy"]),
        siteAbout: json["site_about"] == null
            ? null
            : Contacts.fromMap(json["site_about"]),
        siteTitle: json["site_title"] == null
            ? null
            : Contacts.fromMap(json["site_title"]),
      );

  Map<String, dynamic> toMap() => {
        "contacts": contacts?.toMap(),
        "faq": faq?.toMap(),
        "privacy_policy": privacyPolicy?.toMap(),
        "site_about": siteAbout?.toMap(),
        "site_title": siteTitle?.toMap(),
      };
}

class Contacts {
  String? en;

  Contacts({
    this.en,
  });

  factory Contacts.fromMap(Map<String, dynamic> json) => Contacts(
        en: json["en"],
      );

  Map<String, dynamic> toMap() => {
        "en": en,
      };
}
