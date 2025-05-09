import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // المستخدم مينفعش يقفله
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop(); // بيقفل أعلي دايلوج مفتوح
}
