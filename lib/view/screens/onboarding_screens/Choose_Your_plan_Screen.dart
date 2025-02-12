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
import '../../../utills/CustomSnackbar.dart';
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

  //bool _loading = true;
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

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        controller.isLoading.value = false;
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
        controller.isLoading.value = false;
      });
      return;
    } else if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        controller.isLoading.value = false;
      });
      return;
    } else {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        //  _notFoundIds = productDetailResponse.notFoundIDs;
        // _consumables = consumables;
        _purchasePending = false;
        controller.isLoading.value = false;
      });
    }
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          CustomSnackbar.showError("Alert", PurchaseStatus.error.toString());
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          print('success');
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
      controller.isLoading.value = false;
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
          k1hSizedBox,
          Obx(() {
            return controller.isLoading.value
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _products.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            "No subscription found",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
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
                              : null*/
                                );
                              } else {
                                purchaseParam = PurchaseParam(
                                  productDetails: _products[index],
                                );
                              }
                              controller.isLoading.value = true;
                              _inAppPurchase.buyNonConsumable(
                                  purchaseParam: purchaseParam);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          _products[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        /* Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() {
                                    return Text('jkjjk',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    );
                                  }),
                                  SizedBox(
                                    height: 0.5.h,
                                  )
                                ],
                              ),*/
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
                                        Text(
                                          _products[index].description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
          }),
        ],
      ),
    );
  }
}
