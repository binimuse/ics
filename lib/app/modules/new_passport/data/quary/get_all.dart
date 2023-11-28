class GetallQuery {
  dynamic fetchData() {
    return """
query
{

  
   base_document_types(where: {document_category: {code: {_eq:"NEW_APPLICATION"}}}) {
    id
    name
  }
  base_genders
  {
    description
    name
  }

  base_marital_statuses
  {
    description
    name
  }
  
  base_countries
  {
    id
    name_json
  }

} 
   """;
  }
}
