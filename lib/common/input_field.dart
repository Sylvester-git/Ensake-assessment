import 'package:ensake/utils/assets.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class EnsakeInputField extends StatefulWidget {
  const EnsakeInputField({
    super.key,
    required this.title,
    this.compulsoryField = false,
    this.passwordField = false,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.hintText = "",
    this.svg,
    this.controller,
  });
  final String title;

  final bool compulsoryField;

  final bool passwordField;

  final void Function(String)? onChanged;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? validator;

  final String hintText;

  final String? svg;

  final TextEditingController? controller;

  @override
  State<EnsakeInputField> createState() => _EnsakeInputFieldState();
}

class _EnsakeInputFieldState extends State<EnsakeInputField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.title, style: context.textTheme.bodyMedium),
            widget.compulsoryField
                ? Text(
                  "*",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.primary,
                  ),
                )
                : 0.height,
          ],
        ),
        TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          controller: widget.controller,
          obscureText: widget.passwordField ? isHidden : false,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIconConstraints:
                widget.svg != null
                    ? BoxConstraints(minHeight: 36, maxWidth: 36)
                    : null,
            prefixIcon:
                widget.svg == null
                    ? null
                    : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: SvgPicture.asset(widget.svg!),
                    ),
            suffixIconConstraints:
                widget.passwordField
                    ? BoxConstraints(minHeight: 36, maxWidth: 36)
                    : null,
            suffixIcon:
                !widget.passwordField
                    ? null
                    : InkWell(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: SvgPicture.asset(
                          SvgAssets.hidepassword,
                          colorFilter:
                              isHidden == true
                                  ? null
                                  : ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                        ),
                      ),
                    ),
          ),
          cursorColor: AppColors.primary,
          inputFormatters: widget.inputFormatters,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
