import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';

bool isValidEmail({required String email}) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool isValidPAN({required String panNumber}) {
  return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(panNumber);
}

bool isValidGST({required String gstNumber}) {
  return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$').hasMatch(gstNumber);
}

List<TextInputFormatter> allowOnlyNumbers = [
  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
  FilteringTextInputFormatter.digitsOnly,
];

String getFormattedAddress({required AddressModel address}) {
  return "${address.houseNumber}, ${address.street}, ${address.city}, ${address.state} - ${address.pinCode}, ${address.country}.";
}

String formatTimestamp({required Timestamp timestamp}) {
  DateTime dateTime = timestamp.toDate(); // Convert Timestamp to DateTime
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime); // Format DateTime
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  CustomRangeTextInputFormatter({required this.maxLimit});

  final int maxLimit;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return TextEditingValue(selection: TextSelection.collapsed(offset: newValue.text.length));
    } else if (int.parse(newValue.text) < 1) {
      return TextEditingValue(selection: TextSelection.collapsed(offset: newValue.text.length))
          .copyWith(text: '0');
    }
    return int.parse(newValue.text) > maxLimit
        ? const TextEditingValue().copyWith(text: maxLimit.toString())
        : newValue;
  }
}
