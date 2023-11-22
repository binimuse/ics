class GetUser_byPk_Query {
  dynamic fetchData(String id) {
    return """
        query{        
  users_by_pk(id: "$id") {
       created_at
    email
    name
    id
    phone_number
  }
        
        }  
   """;
  }
}
