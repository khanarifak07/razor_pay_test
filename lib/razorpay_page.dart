import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPaypage extends StatefulWidget {
  const RazorPaypage({super.key});

  @override
  State<RazorPaypage> createState() => _RazorPaypageState();
}

class _RazorPaypageState extends State<RazorPaypage> {
  final Razorpay _razorpay = Razorpay();
  TextEditingController amountCtrl = TextEditingController();

  //open checkout method
  void openCheckout(amount) async {
    var options = {
      'key': 'rzp_test_GcZZFDPP0jHtC4',
      'amount': amount * 100,
      'name': 'Test',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'Wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  //handle payment success
  void handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Success : ${response.paymentId}")));
  }

  //handle paymen failure
  void handlePaymentFailure(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Fail : ${response.message}")));
  }

  //handle external wallet
  void handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("External Wallet : ${response.walletName}")));
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: amountCtrl,
              decoration: const InputDecoration(
                hintText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (amountCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter amount to proceed"),
                    ),
                  );
                } else {
                  int amount = int.parse(amountCtrl.text);
                  openCheckout(amount);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
