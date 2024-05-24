import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'YOUR_API_KEY',
    amount: 25758, // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
    creditCard: CreditCardConfig(saveCard: true, manual: false),
    applePay: ApplePayConfig(
        merchantId: 'YOUR_MERCHANT_ID',
        label: 'YOUR_STORE_NAME',
        manual: false),
  );

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          // handle success.
          break;
        case PaymentStatus.failed:
          // handle failure.
          break;
        case PaymentStatus.initiated:
          break;
        case PaymentStatus.authorized:
         break;
        case PaymentStatus.captured:
         break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ApplePay(
          config: paymentConfig,
          onPaymentResult: onPaymentResult,
        ),
        const Text("or"),
        CreditCard(
          config: paymentConfig,
          onPaymentResult: onPaymentResult,
        )
      ],
    );
  }
}
