import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';

class EnsakeButton extends StatelessWidget {
  const EnsakeButton({
    super.key,
    this.onTap,
    required this.title,
    this.titleColor,
    this.btnColor,
    this.borderColor,
  });

  final void Function()? onTap;
  final String title;
  final Color? titleColor;
  final Color? btnColor;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: context.screenSize.width,
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(color: borderColor ?? AppColors.primary),
          gradient:
              btnColor == null
                  ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withOpacity(.8),
                      AppColors.primary,
                    ],
                  )
                  : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  title,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: titleColor ?? Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
