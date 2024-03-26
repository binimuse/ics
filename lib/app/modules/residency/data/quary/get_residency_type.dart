class GetResidencyTypeQuery {
  dynamic fetchData() {
    return """
query{
  base_residency_types{
    id
    name
    document_category{
      id
      name
      code
    }
    
    
  }
}


   """;
  }
}
