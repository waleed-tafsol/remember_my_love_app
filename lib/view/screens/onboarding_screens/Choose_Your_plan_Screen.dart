import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/in_app_purchase_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/Choose_your_plan_controller.dart';
import '../../../utills/TextUtills.dart';
import '../../widgets/Custom_glass_container.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import 'PaymentScreen.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';


const String _kYearlySubscriptionId = 'rml_premium_year';
const String _kMonthlySubscriptionId = 'rml_premium_monthly';
const List<String> _kProductIds = <String>[
  _kYearlySubscriptionId,
  _kMonthlySubscriptionId,
];



class ChooseYourPlanScreen extends StatefulWidget {
  ChooseYourPlanScreen({super.key});
  static const routeName = "ChooseYourPlanScreen";

  @override
  State<ChooseYourPlanScreen> createState() => _ChooseYourPlanScreenState();
}

class _ChooseYourPlanScreenState extends State<ChooseYourPlanScreen> {
  ChooseYourPlanController controller = Get.put(ChooseYourPlanController());
  HomeScreenController homeController = Get.find();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          // handle error here.
        });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

  /*  final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });*/
  }


  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
       // showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
        //  handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
        /*  final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }*/
        }
        /*if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }*/
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    // if (arguments == null) {
    //   return const Center(
    //       child: Text('No arguments passed in choose your plan.'));
    // }
    return CustomScaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CustomRoundedGlassButton(
                icon: Icons.arrow_back_ios_new,
                ontap: () {
                  Get.back();
                }),
          ),
          Text(
            arguments?["title"] ?? "Choose Your Plan",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          k1hSizedBox,
          Text(
            "Choose a Plan to Avail Special Features",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return  InkWell(
                onTap: (){
                  late PurchaseParam purchaseParam;

                  if (Platform.isAndroid) {
                   /* final GooglePlayPurchaseDetails? oldSubscription =
                    _getOldSubscription(_products[index], purchases);*/

                    purchaseParam = GooglePlayPurchaseParam(
                        productDetails: _products[index],
                       /* changeSubscriptionParam: (oldSubscription != null)
                            ? ChangeSubscriptionParam(
                          oldPurchaseDetails: oldSubscription,
                          replacementMode:
                          ReplacementMode.withTimeProration,
                        )
                            : null*/);
                  } else {
                    purchaseParam = PurchaseParam(
                      productDetails: _products[index],
                    );
                  }
                },
                child: CustomGlassmorphicContainer(
                  width: double.infinity,
                  height: 20.h,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Obx(() {
                              return Text(
                                "\$${_products[index].price ?? 0}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              );
                            }),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return Text(
                                    controller.selectedPackage.value?.packageType ??
                                        "",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  );
                                }),
                                SizedBox(
                                  height: 0.5.h,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.kIconColor,
                            ),
                            k1wSizedBox,
                            Obx(() {
                              return Text(
                                "${controller.homeController.user.value?.package?.sId == controller.selectedPackage.value?.sId ? "" : "Get"} ${controller.selectedPackage.value?.summary ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
       /*   Obx(() {
            return (controller.homeController.user.value?.package?.sId ==
                            controller.selectedPackage.value?.sId ||
                        controller.selectedPackage.value?.packageType ==
                            "free") ||
                    controller.isLoading.value
                ? const SizedBox()
                : controller.homeController.user.value?.package?.packageType ==
                        "free"
                    ? GradientButton(
                        onPressed: () async {
                          await controller.buyPackage();
                        },
                        text: "Select Subscription",
                        gradients: const [Colors.purpleAccent, Colors.blue])
                    : GradientButton(
                        onPressed: () async {
                          // await controller.updateSubscription(
                          //     controller.selectedPackage.value?.sId ?? "");
                          Get.toNamed(PaymentScreen.routeName, arguments: {
                            "renewUpdateOrBuySub": "Update",
                            "package": controller.selectedPackage.value
                          });
                          // await controller.buyPackage(
                          //     controller.selectedPackage.value?.sId ?? "");
                        },
                        text: "Update Subscription",
                        gradients: const [Colors.purpleAccent, Colors.blue]);
          }),
          k2hSizedBox,
          Obx(() {
            final user = controller.homeController.user.value;
            if (user == null || user.subscriptionDueDate == null) {
              return SizedBox();
            }

            final subDueDate = DateTime.parse(user.subscriptionDueDate ?? "");
            final isBefore = DateTime.now().isBefore(subDueDate);
            final isCancelled = user.subscriptionStatus == "canceled";

            // If package is different or still loading, no button is shown
            if (controller.homeController.user.value?.package?.sId !=
                    controller.selectedPackage.value?.sId ||
                controller.isLoading.value) {
              return SizedBox();
            }

            return GradientButton(
              onPressed: () async {
                            *//* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InAppPurchaseScreen()),
                );    *//*          *//*  if (isCancelled) {
                  if (isBefore) {
                    // controller.renewSubscription();
                    Get.toNamed(PaymentScreen.routeName, arguments: {
                      "renewUpdateOrBuySub": "Renew",
                      "package": controller.selectedPackage.value
                    });
                    // await controller.buyPackage(
                    //     controller.selectedPackage.value?.sId ?? "");
                  } else {
                    // controller.resumeSubscription();  // Optionally, resume before the due date
                  }
                } else {
                  controller.cancelSubscription();
                  // await controller
                  //     .buyPackage(controller.selectedPackage.value?.sId ?? "");
                }*//*
              },
              text: isCancelled
                  ? (isBefore ? "Renew Subscription" : "")
                  : "Cancel Subscription",
              gradients: const [Colors.purpleAccent, Colors.blue],
            );
          })*/
        ],
      ),
    );
  }

}
