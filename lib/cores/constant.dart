class Constant {
  static const String userBox = 'userBox';
  static const String userKey = 'userKey';
  // ==========================================
  // PAYMENT MODE
  // ==========================================

  // true  = Paymob الحقيقي
  // false = Payment تجريبي بدون أي بيانات خارجية
  static const bool useRealPaymob = false;

  // ==========================================
  // PAYMOB
  // ==========================================

  // لن يتم استخدامهم عندما useRealPaymob = false
  static const String paymobApiKey = '';

  static const int paymobCardIntegrationId = 0;

  static const String paymobIframeId = '';

  // ==========================================
  // MOCK PAYMENT
  // ==========================================

  static const String mockPaymentKey = 'TEST_PAYMENT_SUCCESS';
}
