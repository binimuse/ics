class GetRenewTypeQuery {
  dynamic fetchData() {
    return """
query MyQuery {
  base_origin_id_renewal_types {
    id
    description
    name
    document_category_code
  }
}

   """;
  }
}
