import 'package:flutter/material.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_service.dart';
import 'package:zimozi_store/utils/payment_service/payments_integration.dart';
import 'package:zimozi_store/utils/views/screen_orientation.dart';
import 'package:zimozi_store/utils/views/status_bar_color.dart';

Future configureAppSettings() async {
  WidgetsFlutterBinding.ensureInitialized();
  await changeStatusColor();
  await setScreenOrientationPortrait();
  await FirebaseService.initFirebase();
  await PaymentsIntegration.setUpStripeConfiguration();
}
