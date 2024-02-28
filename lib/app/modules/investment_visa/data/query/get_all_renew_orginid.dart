class GetallQueryInvestemntVisa {
  dynamic fetchData() {
    return """
{
  base_document_types(where: {document_category: {code: {_eq: "NEW_PASSPORT_APPLICATION_DC"}}}) {
    id
    name
    description
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
    name
    description
  }
  base_allowed_countries {
    country {
      description
    name
    id
    }
  }
    base_family_types
  {
    description
     name
    id
  }
  base_occupations {
    name
    description
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

class GetallQueryInvestemntVisaId {
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
