class GetallQueryRenewOrginId {
  dynamic fetchData() {
    return """
{
  base_document_types(where: {document_category: {code: {_eq: "RENEW_ORIGIN_ID"}}}) {
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

  base_visa_types {
    name
    id
    description
  }
  base_correction_types
  {
    name
    id
    description
  }
}
   """;
  }
}
