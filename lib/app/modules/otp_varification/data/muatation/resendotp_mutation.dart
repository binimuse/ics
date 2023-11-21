class ResendOTPQueryMutation {
  static const String resenddotp = r'''
mutation resendOtp($object: ResendSignupOtpInput!) {
  resendSignupOtp(object: $object) {
    message
  }
}



 ''';
}
