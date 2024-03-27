class GetallQueryResidency {
  dynamic fetchData() {
    return """
{
  base_genders {
    description
    name
  }
  base_company_categories {
    id
    name
    description
  }
  base_woredas {
    id
    name_json
  }
  base_regions {
    id
    description
    name
  }
  base_countries {
    id
    name
    description
  }
  base_allowed_countries(where: {_not: {country: {country_code: {_eq: "ETH"}}}}) {
    country {
      country_code
      description
      name
      id
    }
  }
  base_occupations {
    id
    name
  }
  base_residency_application_urgency_levels {
    code
    name
    id
    price
  }
}



   """;
  }
}

class GetallQueryInvestemntResidency {
  dynamic fetchData(String type) {
    return """
{
  base_document_types(where: {document_category: {code: {_eq: "$type"}}}) {
    id
    name
    description
  }

}
   """;
  }
}
