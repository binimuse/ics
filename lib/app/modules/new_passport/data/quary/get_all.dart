class GetallQuery {
  dynamic fetchData() {
    return """
{
  base_document_types(where: {document_category: {code: {_eq: "NEW_APPLICATION"}}}) {
    id
    name
  }
  base_genders {
    description
    name
  }
  base_marital_statuses {
    description
    name
  }
  base_countries {
    id
    name_json
  }
  base_allowed_countries {
    country {
      id
      name_json
    }
  }
    base_family_types
  {
     name_json
    id
  }
  base_occupations {
    name_json
    id
  }
  base_eye_colors {
    description
    name
  }
  base_hair_colors {
    description
    name
  }
}
   """;
  }
}
