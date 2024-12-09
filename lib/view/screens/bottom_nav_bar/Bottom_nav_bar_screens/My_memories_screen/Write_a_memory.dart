import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/models/Categories.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Recipient_details_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../controllers/Upload_memory_controller.dart';
import '../../../../widgets/Glass_text_field_with_text_widget.dart';

class WriteAMemoryScreen extends GetView<UploadMemoryController> {
  WriteAMemoryScreen({super.key});
  static const routeName = "WriteAMemoryScreen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            children: [
              CustomRoundedGlassButton(
                  icon: Icons.arrow_back_ios_new, ontap: () => Get.back()),
              k2wSizedBox,
              Text(
                "Write a Memory",
                style: TextStyleConstants.headlineLargeWhite(context),
              )
            ],
          ),
          CustomGlassmorphicContainer(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassTextFieldWithTitle(
                    title: 'Title',
                    hintText: "Enter Title",
                    controller: controller.titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  k1hSizedBox,
                  const Text(
                    "Select Category",
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        _showDropdown(context);
                      },
                      child: CustomGlassmorphicContainer(
                          borderRadius: 8,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 2.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Text(controller.selectedCatagory.value ==
                                        null
                                    ? "Catagory"
                                    : controller.selectedCatagory.value?.name ??
                                        "");
                              }),
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.kIconColor,
                              )
                            ],
                          )),
                    ),
                  ),
                  const Text("Description"),
                  k1hSizedBox,
                  SizedBox(
                    height: 20.h,
                    width: double.infinity,
                    child: TextFormField(
                      textAlignVertical: const TextAlignVertical(y: -1.0),
                      expands: true,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(
                        hintText: "Enter Description",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          GradientButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (controller.selectedCatagory.value != null) {
                    Get.toNamed(RecipientDetailsScreen.routeName);
                  } else {
                    CustomSnackbar.showError(
                        "Error", "Please Select a catagory");
                  }
                }
              },
              text: "Add Recipients",
              gradients: const [Colors.purple, Colors.blue])
        ],
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showMenu(
      color: AppColors.kGlassColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          50.w, 38.h, 8.w, 0.0), // Adjust position if needed
      items: controller.categories.map((Category value) {
        return PopupMenuItem<Category>(
          value: value,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(10),
            child: Text(
              value.name!,
              style: TextStyleConstants.bodySmallWhite(context),
            ),
          ),
        );
      }).toList(),
    ).then((selectedValue) {
      controller.selectedCatagory.value = selectedValue;
    });
  }
}
