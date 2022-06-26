import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/modules/new_reading/new_reading_controller.dart';
import 'package:glucose_tracker/src/widgets/app_text_button.dart';

import '../../widgets/app_textformfield.dart';

class AddNewReading extends StatefulWidget {
  AddNewReading({Key? key}) : super(key: key);

  @override
  State<AddNewReading> createState() => _AddNewReadingState();
}

class _AddNewReadingState extends State<AddNewReading> {
  final TextEditingController _valueController = TextEditingController();

  String selectedType = "Before Meals";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Reading"),
      ),
      body: GetX<NewReadingController>(
        builder: (controller) {
          return controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Type",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Type",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  items: const ['Before Meals', 'After Meals'],
                  onChanged: (value) {
                    setState((){
                      selectedType = value!;
                    });
                  },
                  selectedItem: selectedType,
                ),
                AppTextFormField(
                  title: "Value",
                  textEditingController: _valueController,
                  widget: const Icon(Icons.thermostat),
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  hint: '',
                ),
                const SizedBox(
                  height: 40,
                ),
                AppTextButton(
                  onPressed: () async {
                    if(selectedType.isEmpty || _valueController.text.isEmpty) {
                      controller.showSnackbar("Please fill all required fields!");
                    } else {
                      await controller.saveEntry(type: selectedType, value: int.tryParse(_valueController.text)??0);
                    }
                  },
                  buttonText: "SUBMIT",
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
