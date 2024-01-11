import 'dart:core';

import 'package:flutter/material.dart';

bool startsWithZero(String text) {
  RegExp regex = RegExp(r'^0');
  return regex.hasMatch(text);
}

String getNetworkProvider(String phoneNumber) {
  // Remove any non-numeric characters from the phone number
  String numericPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

  // Define regex patterns for each network provider
  RegExp mtnPattern = RegExp(
      r'^((\+234)|0)(803|806|703|703|706|813|816|810|814|803|906|913|916|7025|7026|704)\d{6,7}$');
  RegExp gloPattern =
      RegExp(r'^((\+234)|0)(805|807|705|815|811|905|915)\d{7}$');
  RegExp airtelPattern =
      RegExp(r'^((\+234)|0)(808|802|708|812|701|902|901|904|907|912)\d{7}$');
  RegExp nineMobilePattern = RegExp(r'^((\+234)|0)(809|818|817|909|908)\d{7}$');

  // Check each regex pattern and return the corresponding network provider
  if (mtnPattern.hasMatch(numericPhoneNumber)) {
    debugPrint('Network is MTN');
    return 'MTN';
  } else if (gloPattern.hasMatch(numericPhoneNumber)) {
    debugPrint('Network is Glo');
    return 'Glo';
  } else if (airtelPattern.hasMatch(numericPhoneNumber)) {
    debugPrint('Network is Airtel');
    return 'Airtel';
  } else if (nineMobilePattern.hasMatch(numericPhoneNumber)) {
    debugPrint('Network is 9mobile');
    return '9mobile';
  } else {
    debugPrint('Network is NOT KNOWN');
    return 'Unknown Provider, enter legible number!';
  }
}

// void main() {
//   // Example usage
//   String phoneNumberWithCountryCode = '+2347012345678'; // Replace with the actual phone number
//   String phoneNumberWithoutCountryCode = '07012345678'; // Replace with the actual phone number
//   String providerWithCountryCode = getNetworkProvider(phoneNumberWithCountryCode);
//   String providerWithoutCountryCode = getNetworkProvider(phoneNumberWithoutCountryCode);

//   print('Network Provider with Country Code: $providerWithCountryCode');
//   print('Network Provider without Country Code: $providerWithoutCountryCode');
// }
