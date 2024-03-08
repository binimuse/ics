class GetCompliantService {
  dynamic fetchData() {
    return """
query MyQuery {
  base_complaint_services {
    id
    name
    description
    complaint_types {
      name
      id
    }
  }

}

   """;
  }
}

class BaseCountries {
  dynamic fetchData() {
    return """
query MyQuery {
 base_countries{
    id
    name
  }
 
}

   """;
  }
}
