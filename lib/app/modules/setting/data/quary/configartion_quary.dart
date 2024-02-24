class ConfigurationQuery {
  static dynamic getconfiguration() {
    return '''
query
{
  base_site_configurations
  {
    contacts
    faq
    privacy_policy
    site_about
    site_title
  }
}
 ''';
  }
}
