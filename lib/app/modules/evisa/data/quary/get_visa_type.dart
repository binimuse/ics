class GetVisaTypeQuery {
  dynamic fetchData() {
    return """
{
  base_visa_categories {
    id
    name
    document_category {
      id
      name
      code
    }
    visa_category_validity_types {
      id
      price
      visa_validity_type {
        name
        description
      }
    }
  }
}


   """;
  }
}
