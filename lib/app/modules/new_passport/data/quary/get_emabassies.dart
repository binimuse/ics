class GetEmbassiesQuery {
  dynamic fetchData(String country_id) {
    return """
{	
  base_embassies(where: {state: {country_id: {_eq: "$country_id"}}})
  {
    id
    name_json
    
  }
}
   """;
  }
}
