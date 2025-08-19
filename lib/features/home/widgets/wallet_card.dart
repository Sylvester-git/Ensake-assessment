import 'dart:io';

import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    required this.points,
    required this.rewards,
    this.errormessage,
    this.isloading = false,
  });

  final int points;
  final int rewards;
  final String? errormessage;
  final bool isloading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary.withOpacity(.8), AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Points",
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          isloading
              ? Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Platform.isIOS ? Colors.white : null,
                ),
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    errormessage ?? points.toString(),
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: errormessage == null ? 32 : 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    errormessage == null ? 'pts' : "",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
          isloading || errormessage != null
              ? 0.height
              : Text(
                'Available Rewards: 10',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
        ],
      ),
    );
  }
}
