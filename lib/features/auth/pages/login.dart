import 'package:ensake/common/buttons.dart';
import 'package:ensake/common/input_field.dart';
import 'package:ensake/features/home/pages/home.dart';
import 'package:ensake/utils/assets.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:ensake/utils/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static final routeName = "login-screen";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(Icons.arrow_back_ios_new_rounded),
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: SvgPicture.asset(SvgAssets.help),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 40),
        height: context.screenSize.height * .15,

        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EnsakeButton(
              title: "Log in",
              onTap: () async {
                context.go("/${HomePage.routeName}");
                // if (_formKey.currentState!.validate()) {}
              },
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Dont't have an account? "),
                  TextSpan(
                    text: "Register",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textgray1,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                Text(
                  "Login to your Account",
                  style: context.textTheme.bodyLarge!.copyWith(),
                ),
                5.height,
                Text(
                  "Enter your Email Address and Password",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textgray1,
                  ),
                ),
                30.height,
                EnsakeInputField(
                  title: "Email Address",
                  compulsoryField: true,
                  hintText: "hello@ensake.com",
                  svg: SvgAssets.email,
                  onChanged: (p0) {},
                  validator: Validators.validateEmail,
                ),
                20.height,
                EnsakeInputField(
                  title: "Password",
                  compulsoryField: true,
                  hintText: "• • • • • • • • • • ",
                  passwordField: true,
                  svg: SvgAssets.lock,
                  onChanged: (p0) {},
                  validator: Validators.validatePassword,
                ),
                10.height,
                Text.rich(
                  TextSpan(
                    text: "Forget Password ?",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
