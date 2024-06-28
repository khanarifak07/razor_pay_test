import 'package:flutter/material.dart';
import 'package:razor_pay_test_app/razorpay_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RazorPaypage());
  }
}
