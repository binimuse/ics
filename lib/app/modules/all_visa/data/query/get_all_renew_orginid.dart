class GetallQueryVisa {
  dynamic fetchData() {
    return """
{

  base_genders {
    
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

base_accommodation_types
  {
    id
    name
  }
  base_passport_types{
     id
    name
  }
  base_occupations{
     id
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
