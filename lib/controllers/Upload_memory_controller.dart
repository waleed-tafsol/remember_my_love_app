import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/controllers/MyMemoriesController.dart';
import 'package:remember_my_love_app/models/MemoryModel.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import 'package:remember_my_love_app/services/Auth_token_services.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/TextConstant.dart';
import '../models/SearchUserModel.dart';
import '../models/Categories.dart';
import '../services/MemoryServices.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Write_a_memory.dart';
import '../view/widgets/CustomGlassDailogBox.dart';

class UploadMemoryController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var pickedFiles = <File>[].obs;
  RxString sendTo = "others".obs;
  RxBool buttonVisivility = true.obs;
  final recievingUsername = TextEditingController();
  final recievingUserPassword = TextEditingController();
  RxBool isloading = false.obs;
  RxBool isapproved = true.obs;
  Rx<MemoryModel?> reschedualMemory = Rx<MemoryModel?>(null);
  RxList<String> reschedualMemoryFiles = <String>[].obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  RxList<Recipient> recipients = <Recipient>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  String selectedFormatedDate = "";
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCatagory = Rx<CategoryModel?>(null);
  List<dynamic> imageUploadMimType = [];
  List<String> successFullFilesUploads = [];
  RxList<SearchUserModel> allAvailableUsers = <SearchUserModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await FetchCategories().then(
      (value) {
        if (Get.arguments != null) {
          reschedualMemory.value = Get.arguments as MemoryModel;
          setMemoryData();
        } else {
          recipients.add(Recipient(
            emailController: TextEditingController(),
            ccp: "+1".obs,
            country: "US".obs,
            contactController: TextEditingController(),
            relationController: TextEditingController(),
          ));
        }
      },
    );
  }

  setMemoryData() {
    titleController.text = reschedualMemory.value?.title ?? "";
    descriptionController.text = reschedualMemory.value?.description ?? "";
    DateTime adjustedDate =
        DateTime.parse(reschedualMemory.value!.deliveryDate!).toLocal();
    selectedDate.value = adjustedDate;
    selectedCatagory.value = categories.firstWhere(
        (element) => element.sId == reschedualMemory.value?.category!.sId);
    if (reschedualMemory.value?.sendTo == "same") {
      sendTo.value = "self";
    } else {
      sendTo.value = "others";
      if (reschedualMemory.value?.recipients?.isNotEmpty == true) {
        recipients.clear();
        reschedualMemory.value?.recipients?.forEach((element) {
          recipients.add(Recipient(
            emailController: TextEditingController(text: element?.email),
            ccp: element?.cc?.obs ?? "+92".obs,
            country: element?.country?.obs ?? "US".obs,
            contactController: TextEditingController(text: element?.contact),
            relationController: TextEditingController(text: element?.relation),
          ));
        });
      }
    }
    if (reschedualMemory.value?.files?.isNotEmpty == true) {
      reschedualMemoryFiles.clear();
      reschedualMemory.value?.files?.forEach((element) {
        reschedualMemoryFiles.add(element);
      });
    }
  }

  // Function to change the value of the DateTime variable
  // void updateSelectedDate(DateTime newDate) {
  //   selectedDate.value = newDate;
  // }

  // void updateSelectedTime(TimeOfDay newTime) {
  //   selectedTime.value = newTime;
  // }

  // void recievingUsername(TextEditingValue RecievingUsername) {
  //   recievingUsername.value = RecievingUsername;
  // }

  // void recievingUserPassword(TextEditingValue RecievingUserpassword) {
  //   recievingUserPassword.value = RecievingUserpassword;
  // }

  void addRecipient() {
    recipients.add(Recipient(
      emailController: TextEditingController(),
      ccp: "+1".obs,
      country: "US".obs,
      contactController: TextEditingController(),
      relationController: TextEditingController(),
    ));
  }

  Future<List<SearchUserModel>?> getAvailableUsers(String? email) async {
    try {
      Response? response = await ApiService.getRequest(
        ApiConstants.getAvailableUsers,
        queryParameters: {
          "search": email ?? "",
        },
      );

      if (response?.data != null && response?.data["data"] != null) {
        allAvailableUsers.clear();
        var userList = response?.data["data"]["user"];
        if (userList is List) {
          allAvailableUsers.value = userList
              .map<SearchUserModel>((user) => SearchUserModel.fromJson(user))
              .toList();

          return allAvailableUsers;
        } else {
          Get.snackbar("ERROR", "Invalid user data format received.");
        }
      } else {
        Get.snackbar("ERROR", "No available users found.");
      }
    } on DioException catch (e) {
      // Improved error handling
      if (e.response != null) {
        // Show the error message from the API response if available
        Get.snackbar("ERROR", e.response?.data["message"] ?? e.toString());
      } else {
        // If there's no response, show a generic error message
        Get.snackbar("ERROR", "Something went wrong: ${e.message}");
      }
    } catch (e) {
      // Catch any other errors that might occur (e.g., parsing errors)
      Get.snackbar("ERROR", "An unexpected error occurred: $e");
    }
    return null;
  }

  void removeRecipient(int index) {
    if (recipients.length > 1) {
      recipients.removeAt(index);
    } else {
      Get.snackbar('Error', 'At least one recipient is required.');
    }
  }

  Future<void> pickImageOrVideo() async {
    try {
      // Let the user choose between picking an image or a video
      final XFile? file = await _picker.pickMedia(imageQuality: 100);

      if (file != null) {
        pickedFiles.add(File(file.path)); // Add picked file to the list
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image or video: $e');
    }
  }

  Future showCaptureOptionDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return GlassMorphicDailogBox(
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Take a Photo/Video",
                style: TextStyleConstants.bodyLargeWhite(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () async {
                      Get.back();
                      try {
                        final XFile? file = await _picker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 20,
                            maxWidth: 640,
                            maxHeight: 480);
                        if (file != null) {
                          pickedFiles.add(File(file.path));
                          // Get.snackbar('Success', 'Photo captured successfully');
                        }
                      } catch (e) {
                        CustomSnackbar.showError(
                            'Error', 'Failed to capture photo or video: $e');
                      }
                    },
                    child: Text(
                      'Image',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Get.back();
                      try {
                        final XFile? file = await _picker.pickVideo(
                          source: ImageSource.camera,
                        );
                        if (file != null) {
                          pickedFiles.add(File(file.path));
                        }
                      } catch (e) {
                        CustomSnackbar.showError(
                            'Error', 'Failed to capture photo or video: $e');
                      }
                    },
                    child: Text(
                      'Video',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteFileFromAws() async {
    if (successFullFilesUploads.isNotEmpty) {
      await ApiService.patchRequest(ApiConstants.deleteMemoryFromS3, {
        "files": successFullFilesUploads.map((file) => file).toList(),
      });
      TokenService tokenService = TokenService();
      tokenService.deleteVideosKeys();
    }
  }

  void removeFile(File file) {
    pickedFiles.remove(file);
  }

  HomeScreenController homeController = Get.find();

  void removeAllFiles() {
    pickedFiles.clear();
  }

  Future<void> createMemory() async {
    ColoredPrint.yellow("create Memory initiated");
    isloading.value = true;
    try {
      // convertDateTime();
      await MemoryServices.create_mem(
        title: titleController.value.text,
        description: descriptionController.value.text,
        category: selectedCatagory.value?.sId ?? "",
        deliveryDate: selectedFormatedDate,
        sendTo: sendTo.value == "self" ? "same" : "others",
        recipients: sendTo == "self"
            ? null
            : recipients.map((recipient) => recipient.toMap()).toList(),
        files: successFullFilesUploads,
      );
      removeAllFiles();
      ColoredPrint.green("successful upload memory");
      final HomeScreenController controller = Get.find();
      controller.callMemoriesDates();
      final MyMemoryController memoriescontroller = Get.find();
     await memoriescontroller.fetchMemories();
      // Get.back();
      isloading.value = false;
      TokenService tokenService = TokenService();
      await tokenService.deleteVideosKeys();
      // homeController.callMemoriesDates();
      // myMemoryController.fetchMemories();
      Get.offNamedUntil(SuccessScreen.routeName,
          (route) => route.settings.name == BottomNavBarScreen.routeName,
          arguments: {
            "title": "Memory Created",
            "subTitle": "Memory has been created successfully.",
          });
    } catch (e) {
      isloading.value = false;
      // Get.back();
    }
  }

  Future<void> updateMemory() async {
    ColoredPrint.yellow("update memory initiated");
    isloading.value = true;
    try {
      // convertDateTime();
      await MemoryServices.update_mem(
        id: reschedualMemory.value?.sId ?? "",
        title: titleController.value.text,
        description: descriptionController.value.text,
        category: selectedCatagory.value?.sId ?? "",
        deliveryDate: selectedFormatedDate,
        sendTo: sendTo.value == "self" ? "same" : "others",
        recipients: sendTo == "self"
            ? null
            : recipients.map((recipient) => recipient.toMap()).toList(),
        files: successFullFilesUploads,
      );
      removeAllFiles();
      ColoredPrint.green("successful Updated memory");
      final HomeScreenController controller = Get.find();
      
      controller.getmemories();
   

      Get.back();
      isloading.value = false;
      homeController.callMemoriesDates();
      Get.offNamedUntil(SuccessScreen.routeName,
          (route) => route.settings.name == BottomNavBarScreen.routeName,
          arguments: {
            "title": "Memory Updated",
            "subTitle": "Memory has been Updated successfully.",
          });
    } catch (e) {
      isloading.value = false;
      // Get.back();
    }
  }

  // String date = "";
  // String time = "";

  // String convertDateTime() {
  //   date =
  //       "${selectedDate.value.year.toString().padLeft(4, '0')}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}";
  //   time =
  //       "${selectedTime.value.hour.toString().padLeft(2, '0')}:${selectedTime.value.minute.toString().padLeft(2, '0')}";

  //   return "$date $time";
  // }

  Future<void> uploadMimeTypes() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));

    if (pickedFiles.isEmpty) {
      Get.back();
      Get.toNamed(WriteAMemoryScreen.routeName);
      successFullFilesUploads.addAll(reschedualMemoryFiles);
      return;
    }

    // Get the MIME type for each picked file
    List<String> mimeTypes = pickedFiles.map((file) {
      // Get the MIME type using the file extension
      final mimeType = lookupMimeType(file.path);
      return mimeType ?? "application/octet-stream";
    }).toList();

    ColoredPrint.green(mimeTypes.toString());
    Response? response = await ApiService.postRequest(
      ApiConstants.uploadMimTypes,
      {
        "mimeTypes": mimeTypes,
      },
    );

    ColoredPrint.green(response.toString());

    if (response?.statusCode == 201 && response != null) {
      final jsonresponse = response.data;
      imageUploadMimType = jsonresponse["data"];
      ColoredPrint.green(
          "Mime types uploaded successfully: $imageUploadMimType");

      for (int i = 0; i < imageUploadMimType.length; i++) {
        await uploadToS3Bucket(imageUploadMimType[i], i, mimeTypes[i]);
      }
      if (reschedualMemoryFiles.isNotEmpty) {
        successFullFilesUploads.addAll(reschedualMemoryFiles);
      }
      Get.back();
      Get.toNamed(WriteAMemoryScreen.routeName);
    }
  }

  uploadToS3Bucket(
      Map<String, dynamic> imageMap, int i, String? mimeType) async {
    try {
      final file = pickedFiles[i];
      final fileBytes = await file.readAsBytes();
      final response = await Dio().put(
        imageMap["url"],
        data: fileBytes,
        options: Options(
          headers: {
            "Content-Type": mimeType,
          },
        ),
      );

      if (response.statusCode == 200) {
        successFullFilesUploads.add(imageMap["key"]);
        ColoredPrint.green(
            "Image uploaded successfully: $successFullFilesUploads");
        final tokenservices = TokenService();
        tokenservices.saveVideosKeys(successFullFilesUploads);
      } else {
        ColoredPrint.red("Failed to upload image: ${response.statusCode}");
      }
    } catch (e) {
      ColoredPrint.red("Error uploading image: $e");
    }
  }

  Future<void> FetchCategories() async {
    try {
      Response? response =
          await ApiService.getRequest(ApiConstants.getcategories);
      final Map<String, dynamic> jsonMap = jsonDecode(response!.toString());

      //ColoredPrint.green(jsonMap['data']['categories'].toString());
      for (var element in jsonMap['data']['categories']) {
        categories.add(CategoryModel.fromJson(element));
      }
      //ColoredPrint.green(categories[1].toString());
    } on DioException catch (e) {
      if (e.response != null) {
        Get.snackbar("ERROR", e.toString());
      } else {
        Get.snackbar("ERROR", "Some thing Went wrong");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();
    recievingUsername.dispose();
    recievingUserPassword.dispose();
    for (var element in recipients) {
      element.emailController.dispose();
      element.contactController.dispose();
      element.relationController.dispose();
    }
    super.dispose();
  }
}

class Recipient {
  TextEditingController emailController;
  RxString ccp;
  RxString country;
  TextEditingController contactController;

  TextEditingController relationController;

  Recipient({
    required this.emailController,
    required this.ccp,
    required this.country,
    required this.relationController,
    required this.contactController,
  });

  // Method to convert Recipient to a Map
  Map<String, String> toMap() {
    return {
      "email": emailController.text.trim(),
      "cc": ccp.value,
      "country": country.value,
      "contact": contactController.text.trim(),
      "username": emailController.text.trim(),
      "relation": relationController.text.trim(),
    };
  }
}
