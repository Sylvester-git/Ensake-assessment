import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key, required this.points, required this.rewards});

  final int points;
  final int rewards;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                points.toString(),
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              Text(
                'pts',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
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
