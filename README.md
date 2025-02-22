# Zimozi Store

## Overview
This project is a Flutter-based mobile application that integrates **Firebase** for authentication and data storage, and **Stripe** for payment processing. This README provides setup instructions, key architectural decisions, and important considerations for iOS deployment.

---

## Project Setup

### **1. Prerequisites**
- Flutter **3.7.7** or later
- Firebase Project (configured)
- Stripe Developer Account
- iOS Developer Account (for iOS deployment)

---

## Setup Instructions

### **2. Configure Firebase**
1. **Create a Firebase Project**
    - Go to [Firebase Console](https://console.firebase.google.com/)
    - Click on **Create a project**
    - Follow the setup process

2. **Add Firebase to Flutter App**
    - **Android**: Download `google-services.json` and place it in `android/app/`
    - **iOS**: Download `GoogleService-Info.plist` and place it in `ios/Runner/`
    - **Update Firebase Configuration in Flutter**: Modify `lib/firebase_options.dart` with the new Firebase settings.

3. **Enable Authentication**
    - Navigate to **Firebase Console → Authentication**
    - Enable **Email/Password Sign-In** (or other required methods)

4. **Enable Firestore Database**
    - Go to **Firebase Console → Firestore Database**
    - Click **Create Database** and set it to **Start in test mode**

---

### **3. Configure Stripe Payments**
1. **Create a Stripe Account** at [Stripe Dashboard](https://dashboard.stripe.com/register)
2. **Get API Keys** from **Developers → API keys**
3. **Update Stripe Keys in `lib/config/app_constant.dart`**
   ```dart
   class AppConstants {
     static const String stripePublishableKey = "pk_test_xxxx";
     static const String stripeSecretKey = "sk_test_xxxx";
   }
   ```
4. **Use Stripe in Flutter**
    - Add the `flutter_stripe` package:
      ```sh
      flutter pub add flutter_stripe
      ```
    - Initialize Stripe in the app:
      ```dart
      import 'package:flutter_stripe/flutter_stripe.dart';
      import 'config/app_constant.dart';
 
      Stripe.publishableKey = AppConstants.stripePublishableKey;
      ```

---

## Architecture & Design Decisions

### **4. State Management**
- Uses **Bloc/Cubit** for global state management
- Follows **MVVM (Model-View-ViewModel)** for separation of concerns

### **5. Folder Structure**
```
/lib
  ├── blocs_and_cubits/  # State management (e.g., AuthCubit, CartCubit)
  ├── config/            # App-wide configurations (e.g., constants, themes)
  ├── models/            # Data models (e.g., User, Order, CartItem)
  ├── screens/           # UI Screens (e.g., HomeScreen, LoginScreen, CartScreen)
  ├── utils/             # Utility functions & helpers
  ├── widgets/           # Reusable components (e.g., CustomButton, ProductCard)
  ├── firebase_options.dart  # Firebase initialization file (Needs to be updated with new Firebase settings)
  ├── main.dart          # Entry point of the application
```

---

## iOS Deployment Warning
**Important:** To use Firebase and Stripe on iOS, you must:
- Have an **Apple Developer Account**
- Set up a **new bundle ID** (e.g., `com.example.app`)
- Use the **same bundle ID** in **Firebase project settings**
- Update `lib/firebase_options.dart` with the correct Firebase settings for iOS
- Enable **Push Notifications** and **Background Modes** (if required)
- Run:
  ```sh
  cd ios && pod install
  ```

---

## Support
For any issues or contributions, feel free to create a GitHub issue or reach out to the team.

---

## Repository
Bitbucket Repository: [Zimozi Store](https://bitbucket.org/Akshit-B-Chovatiya/zimozi-store/src/main/)

Thanks.
Akshit B Chovatiya.
+91 6352535216
akshitchovatiya98@gmail.com

