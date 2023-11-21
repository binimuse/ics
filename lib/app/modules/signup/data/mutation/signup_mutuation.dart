class SignupQueryMutation {
  static const String register = r'''
mutation signup($object: SignupInput!) {
  signup(object: $object) {
   message
    user_id
  }
}


 ''';
}
