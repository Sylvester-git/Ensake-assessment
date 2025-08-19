import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TopSnackbar {
  static success({required BuildContext ctx, required String message}) {
    return showTopSnackBar(
      Overlay.of(ctx),
      displayDuration: const Duration(seconds: 1),
      CustomSnackBar.success(message: message),
    );
  }

  static error({required BuildContext ctx, required String message}) {
    return showTopSnackBar(
      Overlay.of(ctx),
      displayDuration: const Duration(seconds: 1),
      CustomSnackBar.error(message: message),
    );
  }

  static info({required BuildContext ctx, required String message}) {
    return showTopSnackBar(
      Overlay.of(ctx),
      displayDuration: const Duration(seconds: 1),
      CustomSnackBar.info(message: message),
    );
  }
}
