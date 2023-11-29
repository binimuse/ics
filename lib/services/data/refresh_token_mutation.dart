class RefreshTokenMutation {
  static const String refreshtoken = '''
mutation refreshToken{
  refreshToken {
    message
    user_id
    tokens {
      access_token
      refresh_token
    }
  }

  }
 ''';
}
