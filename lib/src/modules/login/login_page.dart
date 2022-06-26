import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/modules/login/login_controller.dart';
import 'package:glucose_tracker/src/routes/route_config.dart';
import 'package:glucose_tracker/src/widgets/app_textformfield.dart';

import '../../widgets/app_text_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetX<LoginController>(builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Text(
                          "Hi,\nWelcome",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        AppTextFormField(
                          title: "Phone",
                          hint: "",
                          textEditingController: _phoneController,
                          widget: const Icon(Icons.phone),
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppTextFormField(
                          obscureText: !controller.isPasswordVisible.value,
                          title: "Password",
                          hint: "",
                          textEditingController: _passwordController,
                          widget: IconButton(
                            icon: controller.isPasswordVisible.value
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () => controller.togglePassword(),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        AppTextButton(
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            if (_phoneController.text.length != 10) {
                              controller.showSnackbar(
                                  "Please enter valid mobile number");
                            } else if (_phoneController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              controller.showSnackbar(
                                  "Please fill all required fields!");
                            } else {
                              await controller.doLogin(
                                  _phoneController.text.trim(),
                                  _passwordController.text.trim());
                            }
                          },
                          buttonText: "LOGIN",
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Don\'t you have an account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(fontSize: 16),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Get.toNamed(
                                            RouteConfig.registration),
                                      text: "Register",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              color: Colors.blue, fontSize: 16),
                                    )
                                  ]),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
