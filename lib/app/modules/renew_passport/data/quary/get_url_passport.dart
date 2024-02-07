class GetUrlQueryRenewPassport {
  dynamic fetchData(String extension, String folder_id) {
    return """
{
  getSignedUploadUrl(object: {extension:"$extension",folder_id:"$folder_id"})
  {
    path
    url
  }
}
   """;
  }
}
