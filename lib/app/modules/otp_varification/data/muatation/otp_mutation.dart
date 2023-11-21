class VerifyOTPMutation {
  static const String otp = r'''
mutation($object: VerifyOtpInput!) {
  verifyOtp(object: $object) {
    message
  }
}


 ''';
}
