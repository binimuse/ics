class GetOrginOrder {
  dynamic fetchData() {
    return """
query
{
  ics_all_origin_id_applications(where: {renewal_id: {_is_null: false}}) {
    new_id
    renewal_id
    
    renew_application {
      application_no
      created_at
      
      citizen {
        first_name
      }
    }
    new_application {
      application_no
      created_at
      citizen {
        first_name
      }
    }
  }
 

}

   """;
  }
}
