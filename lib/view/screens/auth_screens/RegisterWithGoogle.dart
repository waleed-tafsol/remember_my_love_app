import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/constants.dart';
import '../../../controllers/RegisterWithGoogleController.dart';
import '../../widgets/Custom_glass_container.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/gradient_button.dart';

class RegisterwithgoogleScreen extends GetView<RegisterWithGoogleController> {
  RegisterwithgoogleScreen({super.key});
  static const routeName = "ResetPassScreen";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Remember My\nLove",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bookos', color: Colors.white, fontSize: 20.sp),
              ),
              CustomGlassmorphicContainer(
                  width: double.maxFinite,
                  // height: 50.h,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Setup Your Profile",
                          style: TextStyleConstants.displayMediumWhite(context),
                        ),
                        k2hSizedBox,
                        Text(
                          "Please Sign up to Start your journey.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        k1hSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Your Name",
                              ),
                              controller: controller.nameController,
                            )
                          ],
                        ),
                        k1hSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Contact is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Your Contact",
                              ),
                              controller: controller.contactController,
                            )
                          ],
                        ),
                        k1hSizedBox,
                      ],
                    ),
                  )),
              SizedBox(
                height: kButtonHeight,
                child: GradientButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signup();
                    }
                  },
                  text: 'Sign Up',
                  gradients: const [
                    Colors.purple,
                    Colors.blue,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
