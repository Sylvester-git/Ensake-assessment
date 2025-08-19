import 'package:ensake/features/controller/api.dart';
import 'package:ensake/features/home/cubit/get_rewards/get_rewards_cubit.dart';
import 'package:ensake/features/home/widgets/available_reward_card.dart';
import 'package:ensake/features/home/widgets/reward_history_card.dart';
import 'package:ensake/features/home/widgets/wallet_card.dart';
import 'package:ensake/utils/assets.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/functions.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static final routeName = "home-page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      fetchRewards();
    });
    super.initState();
  }

  fetchRewards() {
    ApiController.getRewards(context: context);
  }

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
          BlocListener<GetRewardsCubit, GetRewardsState>(
            listener: (context, getrewardstate) {
              if (getrewardstate is ErrorGettingRewards) {
                logOutOnExpiration(
                  errormessage: getrewardstate.errormessage,
                  context: context,
                );
              }
            },
            child: Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  //Wallet card
                  SliverToBoxAdapter(
                    child: BlocBuilder<GetRewardsCubit, GetRewardsState>(
                      builder: (context, getrewardstate) {
                        if (getrewardstate is GettingRewards ||
                            getrewardstate is GetRewardsInitial) {
                          return WalletCard(
                            points: 0,
                            rewards: 0,
                            isloading: true,
                          );
                        }
                        if (getrewardstate is ErrorGettingRewards) {
                          return WalletCard(
                            points: 0,
                            rewards: 0,
                            errormessage: getrewardstate.errormessage,
                          );
                        }
                        if (getrewardstate is GottenRewards) {
                          return WalletCard(
                            points:
                                getrewardstate
                                    .rewardResponseModel
                                    .customerPoints,
                            rewards: 10,
                          );
                        }
                        return 0.height;
                      },
                    ),
                  ),

                  // Available Rewards list
                  BlocBuilder<GetRewardsCubit, GetRewardsState>(
                    builder: (context, getRewardstate) {
                      if (getRewardstate is GettingRewards ||
                          getRewardstate is GetRewardsInitial) {
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Available Rewards',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            ...List.generate(2, (index) {
                              return AvailableRewardCard(isloading: true);
                            }),
                          ]),
                        );
                      }
                      if (getRewardstate is ErrorGettingRewards) {
                        return SliverToBoxAdapter(child: 0.height);
                      }
                      if (getRewardstate is GottenRewards) {
                        return SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Available Rewards',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            ...List.generate(
                              getRewardstate.rewardResponseModel.rewards.length,
                              (index) {
                                return AvailableRewardCard(
                                  rewardModel:
                                      getRewardstate
                                          .rewardResponseModel
                                          .rewards[index],
                                );
                              },
                            ),
                          ]),
                        );
                      }
                      return SliverToBoxAdapter(child: 0.height);
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
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
                      return RewardHistoryCard();
                    }, childCount: 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
