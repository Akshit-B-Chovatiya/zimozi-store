class PaymentRequestModel {
  final double amount;
  final String label;
  final String currencyCode;
  final String countryCode;
  final String merchantDisplayName;
  final String paymentDescription;
  final String note;
  final String customerName;
  final String address;
  final String cityName;
  final String stateCode;
  final String postalCode;
  final String customerEmail;
  final String customerPhone;
  final Function(bool, String,Map<String,dynamic>) onSuccess;
  final Function(bool, String) onError;
  final Function(bool, String) onCancelled;

  PaymentRequestModel(
      {required this.amount,
      required this.currencyCode,
      required this.label,
      required this.countryCode,
      required this.merchantDisplayName,
      required this.note,
      required this.paymentDescription,
      required this.customerName,
      required this.address,
      required this.cityName,
      required this.stateCode,
      required this.postalCode,
      required this.customerEmail,
      required this.customerPhone,
      required this.onError,
      required this.onSuccess,
      required this.onCancelled});
}
