import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/payment_services/payment_request_model.dart';
import 'package:zimozi_store/utils/common/log_services.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';

class PaymentsIntegration {
  static setUpStripeConfiguration() async {
    Stripe.publishableKey = AppConstants.stripePublishableKey;
    await Stripe.instance.applySettings();
  }

  static Future<String> createStripeCustomer(
      {required BuildContext context, required PaymentRequestModel paymentRequestModel}) async {
    Map<String, dynamic>? customerIntent;

    try {
      Map<String, dynamic> body = {
        "name": paymentRequestModel.customerName,
        "email": paymentRequestModel.customerEmail,
        "phone": paymentRequestModel.customerPhone,
        "address": {
          "line1": paymentRequestModel.address,
          "postal_code": paymentRequestModel.postalCode,
          "city": paymentRequestModel.cityName,
          "state": paymentRequestModel.stateCode,
          "country": paymentRequestModel.countryCode
        }
      };
      http.Response response = await http.post(Uri.parse("https://api.stripe.com/v1/customers"),
          headers: {
            "Authorization": "Bearer ${AppConstants.stripeSecretKey}",
            "Content-type": "application/x-www-form-urlencoded",
          },
          body: json.encode(body));
      customerIntent = json.decode(response.body);
    } catch (e) {
      throw Exception(e);
    }
    if (customerIntent != null) {
      return customerIntent["id"];
    } else {
      return "";
    }
  }

  static Future<Map<String, dynamic>> getPaymentIntent(
      {required BuildContext context,
      required PaymentRequestModel paymentRequestModel,
      required String stripeCustomerKey}) async {
    Map<String, dynamic>? paymentIntent;
    try {
      Map<String, dynamic> body = {
        "amount": (paymentRequestModel.amount * 100).toStringAsFixed(0),
        "currency": paymentRequestModel.currencyCode.toUpperCase(),
        "description": paymentRequestModel.paymentDescription,
        "customer": stripeCustomerKey
      };
      var response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
          headers: {
            "Authorization": "Bearer ${AppConstants.stripeSecretKey}",
            "Content-type": "application/x-www-form-urlencoded",
          },
          body: body);
      paymentIntent = json.decode(response.body);
      showLogs(message: "CLIENT SECRET API : $paymentIntent");
    } catch (e) {
      showLogs(message: "ERROR TO CLIENT SECRET : $e");
      throw Exception(e);
    }
    if (paymentIntent != null) {
      showLogs(message: "FINAL TO CLIENT SECRET : $paymentIntent");
      return paymentIntent;
    } else {
      showLogs(message: "FINAL TO CLIENT SECRET ERRO ");
      return {};
    }
  }

  static Future<void> stripePayment(
      {required BuildContext context, required PaymentRequestModel paymentRequestModel}) async {
    showLogs(message: "PAYMENT REQUEST MODEL : ${paymentRequestModel.amount}");
    showLogs(message: "PAYMENT REQUEST MODEL : ${paymentRequestModel.label}");
    showLogs(message: "PAYMENT REQUEST MODEL : ${paymentRequestModel.currencyCode}");
    showLogs(message: "PAYMENT REQUEST MODEL : ${paymentRequestModel.countryCode}");
    showLogs(message: "PAYMENT REQUEST MODEL : ${paymentRequestModel.merchantDisplayName}");

    PaymentSheetAppearance appearance =
        const PaymentSheetAppearance(colors: PaymentSheetAppearanceColors(primary: AppColors.blackColor));

    try {
      showLogs(message: "AMOUNT : ${paymentRequestModel.amount.toInt()}");

      String stripeCustomerKey = "";
      String clientSecretKey = "";
      String paymentIntentKey = "";
      if (context.mounted) {
        stripeCustomerKey =
            await createStripeCustomer(context: context, paymentRequestModel: paymentRequestModel);
      }
      if (context.mounted) {
        Map<String, dynamic> secretData = await getPaymentIntent(
            context: context, paymentRequestModel: paymentRequestModel, stripeCustomerKey: stripeCustomerKey);
        clientSecretKey = secretData["client_secret"];
        paymentIntentKey = secretData["id"];
      }

      showLogs(message: "CLIENT SECRETS : $clientSecretKey");
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          style: ThemeMode.system,
          merchantDisplayName: paymentRequestModel.merchantDisplayName,
          billingDetails: BillingDetails(
              phone: paymentRequestModel.customerPhone,
              address: Address(
                  city: paymentRequestModel.cityName,
                  country: paymentRequestModel.countryCode,
                  line1: paymentRequestModel.address,
                  line2: paymentRequestModel.address,
                  postalCode: paymentRequestModel.postalCode,
                  state: paymentRequestModel.stateCode),
              email: paymentRequestModel.customerEmail,
              name: paymentRequestModel.customerName),
          intentConfiguration: IntentConfiguration(
            mode: IntentMode.paymentMode(
                currencyCode: paymentRequestModel.currencyCode,
                amount: paymentRequestModel.amount.toInt(),
                captureMethod: CaptureMethod.AutomaticAsync,
                setupFutureUsage: IntentFutureUsage.OnSession),
            confirmHandler: (PaymentMethod method, bool v) {
              showLogs(message: "PAYMENT CONFIRMATION HANDLER : ${method.toJson()} || $v");
            },
          ),
          returnURL: "https://com.zimozi.store.app",
          customerId: stripeCustomerKey,
          setupIntentClientSecret: clientSecretKey,
          paymentIntentClientSecret: clientSecretKey,
          appearance: appearance,
        ),
      )
          .then((PaymentSheetPaymentOption? value) async {
        await Stripe.instance.presentPaymentSheet().then((PaymentSheetPaymentOption? value) async {
          showLogs(message: "DATA : $value");
          await fetchPaymentDetails(
              paymentIntentId: paymentIntentKey,
              onUpdate: (v, pd) {
                if (v) {
                  paymentRequestModel.onSuccess(true, "Payment successfully completed!", pd);
                } else {
                  paymentRequestModel.onError(false, "Payment details not found from stripe!");
                }
              });
        });
      });
      // await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      if (e is StripeException) {
        if (context.mounted) {
          showToastMessage(context: context, message: 'Error: ${e.error}');
        }
        if (e.error.code == FailureCode.Canceled) {
          paymentRequestModel.onCancelled(true, "Error : ${e.error.message ?? e.error}");
        } else {
          paymentRequestModel.onError(true, "Error : ${e.error.message ?? e.error}");
        }
      } else {
        paymentRequestModel.onError(true, 'Error: $e');
      }
    }
  }

  static Future<void> fetchPaymentDetails(
      {required String paymentIntentId, required Function(bool, Map<String, dynamic>) onUpdate}) async {
    const String stripeSecretKey = AppConstants.stripeSecretKey; // Replace with your Secret Key
    const String stripeApiUrl = "https://api.stripe.com/v1/payment_intents/";

    final response = await http.get(
      Uri.parse("$stripeApiUrl$paymentIntentId"),
      headers: {
        "Authorization": "Bearer $stripeSecretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> paymentDetails = jsonDecode(response.body);
      onUpdate(true, paymentDetails);
    } else {
      onUpdate(false, {});
    }
  }
}
