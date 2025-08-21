import 'package:ensake/common/buttons.dart';
import 'package:ensake/utils/assets.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../features/controller/api.dart';

class ShowDialog {
  static void showCustomCalimDialog({
    required BuildContext context,
    required String title,
    required String message,
    bool iserror = false,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          alignment: Alignment.center,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          content: Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // icon
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: iserror ? AppColors.error : AppColors.success,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            iserror ? SvgAssets.error : SvgAssets.success,
                          ),
                        ),
                      ),
                      Column(
                        spacing: 3,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            message,
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 12,
                              color: AppColors.textgray1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: AppColors.stroke),
                20.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: EnsakeButton(
                          title: iserror ? "Try Again" : "Cancel",
                          borderColor: AppColors.stroke,
                          onTap:
                              iserror
                                  ? () async {
                                    {
                                      context.pop();
                                    }
                                  }
                                  : () {
                                    ApiController.getRewards(context: context);
                                    context.pop();
                                  },
                          btnColor: Colors.white,
                          titleColor: AppColors.textgray1,
                        ),
                      ),
                      Expanded(
                        child: EnsakeButton(
                          title: "View Details",
                          onTap:
                              iserror
                                  ? () {
                                    context.pop();
                                  }
                                  : () {
                                    ApiController.getRewards(context: context);
                                    context.pop();
                                  },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
