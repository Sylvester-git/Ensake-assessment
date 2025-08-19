import 'package:ensake/features/home/widgets/available_reward_card.dart';
import 'package:ensake/features/home/widgets/wallet_card.dart';
import 'package:ensake/utils/assets.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final routeName = "home-page";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.height,
          // User picture
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.yellow,
                backgroundImage: AssetImage(ImageAssets.avatar),
              ),
              Text(
                "Welcome Moyo",
                style: context.textTheme.bodyLarge!.copyWith(),
              ),
            ],
          ),
          30.height,
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                //Wallet card
                SliverToBoxAdapter(
                  child: WalletCard(points: 5000, rewards: 10),
                ),
                // Available Rewards
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Available Rewards',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // Available Rewards list
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return AvailableRewardCard();
                  }, childCount: 2),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Rewards History',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // Rewards history
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return null;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
