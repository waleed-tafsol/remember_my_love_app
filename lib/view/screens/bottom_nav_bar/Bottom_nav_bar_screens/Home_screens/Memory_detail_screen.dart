import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/assets.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Memory_detail_controller.dart';
import '../../../../../models/memoryModel.dart';
import '../../../../../utills/ConvertDateTime.dart';

class MemoryDetailScreen extends StatelessWidget {
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
    final MemoryModel memory = Get.arguments as MemoryModel;

    // Initialize the controller with the passed memory
    final MemoryDetailController controller =
        Get.put(MemoryDetailController(memory));
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
                height: null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Obx(() {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "${ApiConstants.getPicture}/${controller.selectedImage}",
                              height: 20.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CustomRoundedGlassButton(
                            icon: Icons.more_horiz,
                            ontap: () {},
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.memory.files!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.selectedImage(
                                  controller.memory.files![index].key);
                            },
                            child: Container(
                              width: 20.w,
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 1.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "${ApiConstants.getPicture}/${controller.memory.files![index].key}",
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
                      controller.memory.description ?? "",
                      style: TextStyleConstants.bodyMediumWhite(context),
                    ),
                    k1hSizedBox,
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: AppColors.kIconColor,
                        ),
                        k2wSizedBox,
                        Text(
                          "Scheduled On",
                          style: TextStyleConstants.bodySmallWhite(context),
                        ),
                        const Spacer(),
                        Text(
                          formatISOToCustom(memory.createdAt.toString()),
                          style: TextStyleConstants.bodySmallWhite(context),
                        ),
                      ],
                    ),
                    k1hSizedBox,
                    SizedBox(
                      height: 25.h,
                      child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.memory.recipients?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Recipient 0${index + 1} :",
                                  style: TextStyleConstants.bodyLargeWhite(
                                      context),
                                ),

                                k1hSizedBox,
                                Row(
                                  children: [
                                    Text(
                                      "Email :",
                                      style: TextStyleConstants.bodyLargeWhite(
                                          context),
                                    ),
                                    k1wSizedBox,
                                    Text(
                                      controller.memory.recipients![index]
                                              .email ??
                                          "",
                                      style: TextStyleConstants.bodyLargeWhite(
                                          context),
                                    ),
                                  ],
                                ),
                                k1hSizedBox,
                                Row(
                                  children: [
                                    Text(
                                      "Contact :",
                                      style: TextStyleConstants.bodyLargeWhite(
                                          context),
                                    ),
                                    k1wSizedBox,
                                    Text(
                                      controller.memory.recipients![index]
                                              .contact ??
                                          "",
                                      style: TextStyleConstants.bodyLargeWhite(
                                          context),
                                    ),
                                  ],
                                ),
                                k1hSizedBox,
                                // Text(
                                //   "Recipient 02 :",
                                //   style: TextStyleConstants.bodyLargeWhite(context),
                                // ),
                                // k1hSizedBox,
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Email :",
                                //       style: TextStyleConstants.bodyLargeWhite(context),
                                //     ),
                                //     k1wSizedBox,
                                //     Text(
                                //       "johndoe@gmail.com",
                                //       style: TextStyleConstants.bodyLargeWhite(context),
                                //     ),
                                //   ],
                                // ),
                                // k1hSizedBox,
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Contact :",
                                //       style: TextStyleConstants.bodyLargeWhite(context),
                                //     ),
                                //     k1wSizedBox,
                                //     Text(
                                //       "+ 454 5412 3548",
                                //       style: TextStyleConstants.bodyLargeWhite(context),
                                //     ),
                                //   ],
                                // ),
                              ],
                            );
                          }),
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
