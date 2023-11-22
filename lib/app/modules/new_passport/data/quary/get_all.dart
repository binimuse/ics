class GetallQuery {
  dynamic fetchData() {
    return """
query
{
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
