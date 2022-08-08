import 'package:falcanli/Controllers/UserControllers/UserProfileController/user_profile_controller.dart';
import 'package:falcanli/Globals/Constans/colors.dart';
import 'package:falcanli/Globals/Widgets/custom_textfield.dart';
import 'package:falcanli/Models/job.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AutoCompletTF();
}

class _AutoCompletTF extends State<JobPicker> {
  UserProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Obx(
        () => Column(
          children: [
            Card(
              child: Autocomplete<Job>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return profileController.jobList
                      .where((Job county) => county.name!
                          .toLowerCase()
                          .startsWith(textEditingValue.text.toLowerCase()))
                      .toList();
                },
                displayStringForOption: (Job option) => option.name!,
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: mainColor,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Mesleğinizi yazınız",
                      labelStyle: TextStyle(
                        color: mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  );
                },
                onSelected: (Job selection) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<Job> onSelected,
                    Iterable<Job> options) {
                  return Align(
                    alignment: Alignment.center,
                    child: Material(
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(right: 24.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Job option = options.elementAt(index);

                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                                profileController.selectedJob?.name =
                                    option.name ?? "";
                                profileController.selectedJobId.value =
                                    option.id ?? 0;
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.black12
                                      : Colors.grey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    option.name!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            profileController.selectedJobId.value == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                        "Belirtiniz...", profileController.jobController),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
