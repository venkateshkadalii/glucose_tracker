import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/modules/registration/registration_controller.dart';

import '../../models/user.dart';
import '../../widgets/app_text_button.dart';
import '../../widgets/app_textformfield.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String selectedGender = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetX<RegistrationController>(builder: (controller) {
          return (controller.isLoading.value)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hi,\nRegister here",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        AppTextFormField(
                          title: "First name",
                          hint: "",
                          textEditingController: _firstNameController,
                          widget: const Icon(Icons.person),
                          textInputAction: TextInputAction.next,
                        ),
                        AppTextFormField(
                          title: "Last name",
                          hint: "",
                          textEditingController: _lastNameController,
                          widget: const Icon(Icons.person),
                          textInputAction: TextInputAction.next,
                        ),
                        AppTextFormField(
                          title: "Age",
                          hint: "",
                          textEditingController: _ageController,
                          widget: const Icon(Icons.numbers),
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Gender",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownSearch<String>(
                          popupProps: PopupProps.bottomSheet(
                            showSelectedItems: true,
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Gender",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          items: const ['Male', 'Female'],
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value ?? '';
                            });
                          },
                          selectedItem: selectedGender,
                        ),
                        AppTextFormField(
                          title: "Phone*",
                          hint: "",
                          textEditingController: _phoneController,
                          widget: const Icon(Icons.phone),
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.phone,
                        ),
                        AppTextFormField(
                          obscureText: !controller.isPasswordVisible.value,
                          title: "Password*",
                          hint: "",
                          textEditingController: _passwordController,
                          widget: IconButton(
                              icon: controller.isPasswordVisible.value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                controller.togglePasswordVisibility();
                              }),
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AppTextButton(
                          onPressed: () async {
                            if (_phoneController.text.length != 10) {
                              controller.showSnackbar(
                                  "Please enter valid mobile number!");
                            } else if (_phoneController.text.isEmpty ||
                                selectedGender.isEmpty ||
                                _firstNameController.text.isEmpty ||
                                _lastNameController.text.isEmpty ||
                                _ageController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              controller.showSnackbar(
                                  "Please fill all required fields!");
                            } else {
                              await controller.saveUser(User(
                                firstName: _firstNameController.text.trim(),
                                lastName: _lastNameController.text.trim(),
                                age: int.tryParse(_ageController.text.trim()),
                                gender: selectedGender,
                                phone: _phoneController.text.trim(),
                                password: _passwordController.text.trim(),
                              ));
                            }
                          },
                          buttonText: "REGISTER",
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
