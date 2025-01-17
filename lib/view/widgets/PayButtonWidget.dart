import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PlatformPayButtonWidget extends StatelessWidget {
  final Future<void> Function(BuildContext context) onGooglePayPressed;
  final Future<void> Function(BuildContext context) onApplePayPressed;

  PlatformPayButtonWidget({
    required this.onGooglePayPressed,
    required this.onApplePayPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? PlatformPayButton(
              type: PlatformButtonType.pay,
              appearance: PlatformButtonStyle.automatic,
              onPressed: () async {
                await onGooglePayPressed(context);
              },
            )
          : Platform.isIOS
              ? PlatformPayButton(
                  type: PlatformButtonType.pay,
                  appearance: PlatformButtonStyle.automatic,
                  onPressed: () async {
                    await onApplePayPressed(context);
                  },
                )
              : const Text('Unsupported platform'),
    );
  }
}
