class SignupQueryMutation {
  static const String register = r'''
mutation signup($email: String!, $name: String!,$password: String!,$phone_number: String!){
  signUp(
    email: $email, 
    name: $name, 
    password: $password, 
    phone_number: $phone_number, 
  ) {
       message
    user_id
  }
}
 ''';
}
