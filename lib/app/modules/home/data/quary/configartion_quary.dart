class GetUser_byPk_Query {
  dynamic fetchData(String id) {
    return """
        query{        
  users_by_pk(id: "$id") {
       
    email
    name
    id
    phone_number
  }
        
        }  
   """;
  }
}
