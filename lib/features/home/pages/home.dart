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

import '../../../common/dialog.dart';
import '../../auth/cubit/current_user/get_current_user_cubit.dart';
import '../cubit/claim_reward/claim_reward_cubit.dart';

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
    final currentCustomer = context.watch<GetCurrentUserCubit>();
    final claimRewardCubit = context.watch<ClaimRewardCubit>();
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
                currentCustomer.state.customer == null
                    ? "Welcome"
                    : "Welcome ${currentCustomer.state.customer?.firstName}",
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
                            rewards: getAvailableRewardCount(
                              reviewmodel:
                                  getrewardstate.rewardResponseModel.rewards,
                              points:
                                  getrewardstate
                                      .rewardResponseModel
                                      .customerPoints,
                            ),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Available Rewards',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            ...List.generate(2, (index) {
                              return AvailableRewardCard(
                                skelentinized: true,
                                customerpoints: 0,
                              );
                            }),
                          ]),
                        );
                      }
                      if (getRewardstate is ErrorGettingRewards) {
                        return SliverToBoxAdapter(child: 0.height);
                      }
                      if (getRewardstate is GottenRewards) {
                        return BlocListener<ClaimRewardCubit, ClaimRewardState>(
                          listener: (context, claimRewardstate) {
                            if (claimRewardstate is ErrorClaimingReward) {
                              ShowDialog.showCustomCalimDialog(
                                context: context,
                                title: "Failed",
                                message: claimRewardstate.errormessage,
                                iserror: true,
                              );
                            }
                            if (claimRewardstate is ClaimedReward) {
                              ShowDialog.showCustomCalimDialog(
                                context: context,
                                title: "Points Earned",
                                message: "You claimed a bonus.",
                              );
                            }
                          },
                          child: SliverList(
                            delegate: SliverChildListDelegate([
                              getAvailableRewards(
                                    reviewmodel:
                                        getRewardstate
                                            .rewardResponseModel
                                            .rewards,
                                  ).isEmpty
                                  ? 0.height
                                  : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Available Rewards',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(fontSize: 20),
                                    ),
                                  ),

                              ...List.generate(
                                getAvailableRewards(
                                  reviewmodel:
                                      getRewardstate
                                          .rewardResponseModel
                                          .rewards,
                                ).length,
                                (index) {
                                  return AvailableRewardCard(
                                    customerpoints:
                                        getRewardstate
                                            .rewardResponseModel
                                            .customerPoints,
                                    rewardModel:
                                        getAvailableRewards(
                                          reviewmodel:
                                              getRewardstate
                                                  .rewardResponseModel
                                                  .rewards,
                                        )[index],
                                    isloading:
                                        claimRewardCubit.state
                                            is ClaimingReward &&
                                        (claimRewardCubit.state
                                                    as ClaimingReward)
                                                .rewardId ==
                                            getAvailableRewards(
                                              reviewmodel:
                                                  getRewardstate
                                                      .rewardResponseModel
                                                      .rewards,
                                            )[index].id,
                                    onTap: () {
                                      ApiController.claimReward(
                                        context: context,
                                        rewardID:
                                            getAvailableRewards(
                                              reviewmodel:
                                                  getRewardstate
                                                      .rewardResponseModel
                                                      .rewards,
                                            )[index].id,
                                      );
                                    },
                                  );
                                },
                              ),
                            ]),
                          ),
                        );
                      }
                      return SliverToBoxAdapter(child: 0.height);
                    },
                  ),
                  // Reward History
                  BlocBuilder<GetRewardsCubit, GetRewardsState>(
                    builder: (context, getRewardstate) {
                      if (getRewardstate is GettingRewards ||
                          getRewardstate is GetRewardsInitial) {
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Rewards History',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            ...List.generate(2, (index) {
                              return RewardHistoryCard(isloading: true);
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
                            getClaimedRewards(
                                  reviewmodel:
                                      getRewardstate
                                          .rewardResponseModel
                                          .rewards,
                                ).isEmpty
                                ? 0.height
                                : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    'Rewards History',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(fontSize: 20),
                                  ),
                                ),

                            ...List.generate(
                              getClaimedRewards(
                                reviewmodel:
                                    getRewardstate.rewardResponseModel.rewards,
                              ).length,
                              (index) {
                                return RewardHistoryCard(
                                  rewardModel:
                                      getClaimedRewards(
                                        reviewmodel:
                                            getRewardstate
                                                .rewardResponseModel
                                                .rewards,
                                      )[index],
                                );
                              },
                            ),
                          ]),
                        );
                      }
                      return SliverToBoxAdapter(child: 0.height);
                    },
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
