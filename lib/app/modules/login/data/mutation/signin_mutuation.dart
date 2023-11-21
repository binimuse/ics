class SignInQueryMutation {
  static const String login = r'''
mutation signip ($object: LoginInput!) {
  login(object: $object) {
    message
    tokens {
      access_token
      refresh_token
    }
    user_id
  }
}


 ''';
}
