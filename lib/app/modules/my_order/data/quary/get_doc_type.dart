class GetDocType {
  dynamic fetchData() {
    return """
{
  base_document_types(where: {document_category: {code: {_eq: "NEW_ORIGIN_ID_APPLICATION_DC"}}}) {
    id
    name
    description
  }

}
   """;
  }
}
