import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/in_app_purchase_screen.dart';
import 'package:remember_my_love_app/models/in_app_model.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/Choose_your_plan_controller.dart';
import '../../../utills/CustomSnackbar.dart';
import '../../widgets/Custom_glass_container.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import 'dart:async';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

class ChooseYourPlanScreen extends StatefulWidget {
  const ChooseYourPlanScreen({super.key});

  static const routeName = "ChooseYourPlanScreen";

  @override
  State<ChooseYourPlanScreen> createState() => _ChooseYourPlanScreenState();
}

class _ChooseYourPlanScreenState extends State<ChooseYourPlanScreen> {
  ChooseYourPlanController controller = Get.put(ChooseYourPlanController());
  HomeScreenController homeController = Get.find();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _isClickPurchase = false;
  bool _isAvailable = false;
  bool _purchasePending = false;

  //bool _loading = true;
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  final List<String> _kProductIds = <String>[];
  String? _queryProductError;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getAllPackages().then((value) {
        if (value) {
          for (int i = 0; i < controller.packages.length; i++) {
            if (controller.packages[i].packageId!.isNotEmpty) {
              _kProductIds.add(controller.packages[i].packageId!);
            }
          }
          print(_kProductIds);
          final Stream<List<PurchaseDetails>> purchaseUpdated =
              _inAppPurchase.purchaseStream;
          _subscription = purchaseUpdated.listen(
              (List<PurchaseDetails> purchaseDetailsList) async {
            controller.isLoading.value = true;
            await _listenToPurchaseUpdated(purchaseDetailsList);
          }, onDone: () {
            _subscription.cancel();
          }, onError: (Object error) {
            // handle error here.
          });
          initStoreInfo();
        }
      });
    });

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
    LinkedHashSet<String> productIdSets = LinkedHashSet<String>.from(_kProductIds);
    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(productIdSets);
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
    }

    final List<ProductDetails> customOrderedList = [];
    // First, add all products to the list
    customOrderedList.addAll(productDetailResponse.productDetails);
    
    // Then sort them based on the desired order
    customOrderedList.sort((a, b) {
      final order = {
        'rml_basic_monthly': 0,
        'rml_basic_yearly': 1,
        'rml_premium_monthly': 2,
        'rml_premium_year': 3,
      };
      return (order[a.id] ?? 999).compareTo(order[b.id] ?? 999);
    });

    setState(() {
      _isAvailable = isAvailable;
      _products = customOrderedList;
      _purchasePending = false;
      controller.isLoading.value = false;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          CustomSnackbar.showError("Alert", PurchaseStatus.error.toString());
          controller.isLoading.value = false;
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (_isClickPurchase) {
            if (purchaseDetails is GooglePlayPurchaseDetails) {
              await controller
                  .updateSubscription(
                      inAppModel: InAppModel(
                          isPending: purchaseDetails.pendingCompletePurchase,
                          packageName:
                              purchaseDetails.billingClientPurchase.packageName,
                          productId: purchaseDetails.productID,
                          transactionId: "",
                          //  originalTransactionId: "",
                          status: purchaseDetails.status.name,
                          verificationData: VerificationData(
                              source: purchaseDetails.verificationData.source,
                              receiptData: purchaseDetails
                                  .verificationData.serverVerificationData),
                          isAcknowledged: purchaseDetails
                              .billingClientPurchase.isAcknowledged,
                          purchaseToken: purchaseDetails
                              .billingClientPurchase.purchaseToken))
                  .then((value) {
                setState(() {
                  _isClickPurchase = false;
                });
              });
            }
            if (purchaseDetails is AppStorePurchaseDetails) {
              await controller
                  .updateSubscription(
                      inAppModel: InAppModel(
                          isPending: purchaseDetails.pendingCompletePurchase,
                          packageName: '',
                          productId: purchaseDetails.productID,
                          transactionId: purchaseDetails.purchaseID!,
                          // originalTransactionId: purchaseDetails.skPaymentTransaction.,
                          status: purchaseDetails.status.name,
                          verificationData: VerificationData(
                              source: purchaseDetails.verificationData.source,
                              receiptData: purchaseDetails
                                  .verificationData.serverVerificationData),
                          isAcknowledged: true,
                          purchaseToken: ''))
                  .then((value) {
                setState(() {
                  _isClickPurchase = false;
                });
              });
            }
          }
          //  print(purchaseDetails.verificationData.serverVerificationData);
          /*  final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }*/
        } else {
          setState(() {
            _isClickPurchase = false;
          });
          controller.isLoading.value = false;
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
      body: Obx(() {
        return homeController.isloading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                  Visibility(
                    visible: homeController.user.value!.subscription!.isEmpty,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: CustomGlassmorphicContainer(
                        borderGradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.green,
                            Colors.greenAccent,
                          ],
                        ),
                        child: Text(
                          "Currently You Have Free Subscription Of 105MB Storage",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                        ),
                      ),
                    ),
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
                                    "Fetching subscriptions..",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _products.length,
                                    itemBuilder: (context, index) {
                                      String subTitle = _products[index]
                                          .title
                                          .replaceAll(RegExp(r'\(.*?\)'), '');
                                      return Obx(() {
                                        return InkWell(
                                          onTap: () {
                                            if (homeController
                                                    .user.value!.subscription !=
                                                _products[index].id) {
                                              controller.isLoading.value = true;
                                              Widget okButton = TextButton(
                                                child: Text("OK",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.sp)),
                                                onPressed: () {
                                                  Get.back();
                                                  late PurchaseParam
                                                      purchaseParam;
                                                  if (Platform.isAndroid) {
                                                    /* final GooglePlayPurchaseDetails? oldSubscription =
                                                              _getOldSubscription(_products[index], purchases);*/
                                                    purchaseParam =
                                                        GooglePlayPurchaseParam(
                                                      productDetails:
                                                          _products[index],
                                                      /* changeSubscriptionParam: (oldSubscription != null)
                                        ? ChangeSubscriptionParam(
                                      oldPurchaseDetails: oldSubscription,
                                      replacementMode:
                                      ReplacementMode.withTimeProration,
                                                                  )
                                        : null*/
                                                    );
                                                  } else {
                                                    purchaseParam =
                                                        PurchaseParam(
                                                      productDetails:
                                                          _products[index],
                                                    );
                                                  }
                                                  _inAppPurchase
                                                      .buyNonConsumable(
                                                          purchaseParam:
                                                              purchaseParam)
                                                      .then((value) {
                                                    if (value) {
                                                      setState(() {
                                                        controller.isLoading
                                                            .value = value;
                                                        _isClickPurchase =
                                                            value;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        controller.isLoading
                                                            .value = value;
                                                        _isClickPurchase =
                                                            value;
                                                      });
                                                    }
                                                  });
                                                },
                                              );
                                              Widget cancelButton = TextButton(
                                                child: Text("Cancel",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.sp)),
                                                onPressed: () {
                                                  Get.back();
                                                  controller.isLoading.value =
                                                      false;
                                                },
                                              );

                                              AlertDialog alert = AlertDialog(
                                                backgroundColor:
                                                    AppColors.kSecondaryColor,
                                                title: Text(
                                                  "Note",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp),
                                                ),
                                                content: Text(
                                                  "This is an auto-renewable subscription provides seamless access, renewing automatically unless canceled.",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.sp),
                                                ),
                                                actions: [
                                                  cancelButton,
                                                  okButton,
                                                ],
                                              );

                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            } else {
                                              CustomSnackbar.showSuccess('Note',
                                                  'Already subscribe ${_products[index].title}');
                                            }
                                          },
                                          child: CustomGlassmorphicContainer(
                                            borderGradient: homeController.user
                                                        .value!.subscription ==
                                                    _products[index].id
                                                ? LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Colors.green,
                                                      Colors.greenAccent,
                                                    ],
                                                  )
                                                : null,
                                            width: double.infinity,
                                            height: 25.h,
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            subTitle,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20.sp),
                                                          ),
                                                        ),
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Visibility(
                                                        visible: homeController
                                                                .user
                                                                .value!
                                                                .subscription ==
                                                            _products[index].id,
                                                        child: const Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      k1wSizedBox,
                                                      Text(
                                                        '${_products[index].description} for just ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    18.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    _products[index].price,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22.sp),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    }),
                              );
                  }),
                ],
              );
      }),
    );
  }
}
