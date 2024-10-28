import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/assets.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Memory_detail_controller.dart';

class MemoryDetailScreen extends GetView<MemoryDetailController> {
  MemoryDetailScreen({super.key});
  static const routeName = "MemoryDetailScreen";
  final List<String> images = [
    Image_assets.userImage,
    Image_assets.animation_cloud_back,
    Image_assets.scaffold_image,
    Image_assets.animation_cloud_front,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomRoundedGlassButton(
                    icon: Icons.arrow_back_ios_new,
                    ontap: () {
                      Get.back();
                    }),
                k2wSizedBox,
                Text("My Memories",
                    style: TextStyleConstants.headlineLargeWhite(context)),
              ],
            ),
            CustomGlassmorphicContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      controller.selectedImage.value,
                      height: 20.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
                SizedBox(
                  height: 10.h,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.images.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedImage(controller.images[index]);
                        },
                        child: Container(
                          width: 20.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 1.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                    controller.images[index],
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "Description :",
                  style: TextStyleConstants.bodyLargeWhite(context),
                ),
                k1hSizedBox,
                Text(
                  "It is a long established fact that a reader will be distracted by the readable"
                  " content of a page when looking at its layout."
                  "It is a long established fact that a reader will be"
                  " distracted by the readable content of a page when looking at its layout.",
                  style: TextStyleConstants.bodyMediumWhite(context),
                ),
                k1hSizedBox,
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: AppColors.kIconColor,
                    ),
                    k1wSizedBox,
                    Text(
                      "Scheduled On",
                      style: TextStyleConstants.bodySmallWhite(context),
                    ),
                    const Spacer(),
                    Text(
                      "Friday, 09 July 2024 - 09:00 PM",
                      style: TextStyleConstants.bodySmallWhite(context),
                    ),
                  ],
                ),
                k1hSizedBox,
                Text(
                  "Recipient 01 :",
                  style: TextStyleConstants.bodyLargeWhite(context),
                ),
                k1hSizedBox,
                Row(
                  children: [
                    Text(
                      "Email :",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                    k1wSizedBox,
                    Text(
                      "johndoe@gmail.com",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                  ],
                ),
                k1hSizedBox,
                Row(
                  children: [
                    Text(
                      "Contact :",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                    k1wSizedBox,
                    Text(
                      "+ 454 5412 3548",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                  ],
                ),
                k1hSizedBox,
                Text(
                  "Recipient 02 :",
                  style: TextStyleConstants.bodyLargeWhite(context),
                ),
                k1hSizedBox,
                Row(
                  children: [
                    Text(
                      "Email :",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                    k1wSizedBox,
                    Text(
                      "johndoe@gmail.com",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                  ],
                ),
                k1hSizedBox,
                Row(
                  children: [
                    Text(
                      "Contact :",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                    k1wSizedBox,
                    Text(
                      "+ 454 5412 3548",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                  ],
                ),
              ],
            )),
            GradientButton(
                onPressed: () {},
                text: "Reschedule Memory",
                gradients: const [Colors.purple, Colors.blue])
          ],
        ),
      ),
    );
  }
}
