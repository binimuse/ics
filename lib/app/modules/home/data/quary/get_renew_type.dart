class GetRenewTypeQuery {
  dynamic fetchData() {
    return """
query MyQuery {
  base_origin_id_renewal_types(where: {parent_type_id: {_is_null: true}}) {
    id
    name
    description
    child_types {
      id
      name
      description
      document_category_code
      origin_id_renewal_instructions {
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
