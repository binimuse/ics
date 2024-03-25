class GetResidencyTypeQuery {
  dynamic fetchData() {
    return """
query{
  base_residency_types{
    
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
