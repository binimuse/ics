class GetRenewTypePassportQuery {
  dynamic fetchData() {
    return """
query MyQuery {
  base_passport_renewal_types(where: {parent_type_id: {_is_null: true}}) {
    id
    name
    
    description
    child_types {
      id
      name
      description
      document_category_code
      passport_renewal_instructions {
        id
        title
        description
      }
    }
  }

  
}


   """;
  }
}
