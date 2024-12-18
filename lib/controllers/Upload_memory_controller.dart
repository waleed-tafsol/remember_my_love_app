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
import 'package:remember_my_love_app/services/ApiServices.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/constants.dart';
import '../models/SearchUserModel.dart';
import '../models/Categories.dart';
import '../services/MemoryServices.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Memory_scheduled_succeccfully.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Write_a_memory.dart';
import '../view/widgets/CustomGlassDailogBox.dart';

class UploadMemoryController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var pickedFiles = <File>[].obs;
  RxString sendTo = "others".obs;
  RxBool buttonVisivility = true.obs;
  final recievingUsername = TextEditingController();
  final recievingUserPassword = TextEditingController();
  final recipientRelation = TextEditingController();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  RxList<Recipient> recipients = <Recipient>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 0, minute: 0).obs;
  List<Category> categories = [];
  Rx<Category?> selectedCatagory = Rx<Category?>(null);
  List<dynamic> imageUploadMimType = [];
  List<String> successFullFilesUploads = [];
  RxList<SearchUserModel> allAvailableUsers = <SearchUserModel>[].obs;
  RxBool lockAllFields = true.obs;
  final uploadProgress = Rx<double>(0.0);

  @override
  void onInit() async {
    super.onInit();
    await FetchCategories();
    recipients.add(Recipient(
      emailController: TextEditingController(),
      contactController: TextEditingController(),
      relationController: TextEditingController(),
    ));
  }

  void check_null(var param) {
    return param != null ? param : Exception("null field found");
  }

  // Function to change the value of the DateTime variable
  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateSelectedTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  // void recievingUsername(TextEditingValue RecievingUsername) {
  //   recievingUsername.value = RecievingUsername;
  // }

  // void recievingUserPassword(TextEditingValue RecievingUserpassword) {
  //   recievingUserPassword.value = RecievingUserpassword;
  // }

  void reciepint_relation(TextEditingValue relation) {
    recipientRelation.value = relation;
  }

  void addRecipient() {
    recipients.add(Recipient(
      emailController: TextEditingController(),
      contactController: TextEditingController(),
      relationController: TextEditingController(),
    ));
  }

  Future<List<SearchUserModel>?> getAvailableUsers(String? email) async {
    try {
      Response? response = await ApiService.getRequest(
        ApiConstants.getAvailableUsers,
        queryParameters: {
          "email": email ?? "",
        },
      );

      if (response?.data != null && response?.data["data"] != null) {
        var userList = response?.data["data"]["user"];
        if (userList is List) {
          allAvailableUsers.clear();
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
      final XFile? file = await _picker.pickMedia();

      if (file != null) {
        pickedFiles.add(File(file.path)); // Add picked file to the list
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image or video: $e');
    }
  }

  Future<void> takePhotoOrVideo(BuildContext context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final isPhoto = await _showCaptureOptionDialog(context);
      if (isPhoto) {
        // Capture a photo
        final XFile? file = await _picker.pickImage(source: ImageSource.camera);
        if (file != null) {
          pickedFiles.add(File(file.path)); // Add the photo file to the list
          Get.snackbar('Success', 'Photo captured successfully');
        }
      } else {
        // Capture a video
        final XFile? file = await _picker.pickVideo(source: ImageSource.camera);
        if (file != null) {
          pickedFiles.add(File(file.path)); // Add the video file to the list
          Get.snackbar('Success', 'Video captured successfully');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to capture photo or video: $e');
    }
  }

  Future<bool> _showCaptureOptionDialog(BuildContext context) async {
    bool isPhoto = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return GlassMorphicDailogBox(
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              k2hSizedBox,
              ElevatedButton(
                onPressed: () {
                  isPhoto = true;
                  Get.back();
                },
                child: const Text('Capture Photo'),
              ),
              ElevatedButton(
                onPressed: () {
                  isPhoto = false;
                  Get.back();
                },
                child: const Text('Capture Video'),
              ),
            ],
          ),
        );
      },
    );

    return isPhoto;
  }

  void removeFile(File file) {
    pickedFiles.remove(file);
    print("function ontap");
  }

  void removeAllFiles() {
    pickedFiles.clear();
  }

  Future<void> createMemory() async {
    ColoredPrint.yellow("successful initiated");
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      convertDateTime();
      await Memoryservices.create_mem(
        title: titleController.value.text,
        description: descriptionController.value.text,
        category: selectedCatagory.value?.sId ?? "",
        deliveryDate: date,
        deliveryTime: time,
        sendTo: sendTo.string,
        recipients: recipients.map((recipient) => recipient.toMap()).toList(),
        files: successFullFilesUploads,
      );
      removeAllFiles();
      ColoredPrint.green("successful upload memory");
      final HomeScreenController controller = Get.find();
      controller.getmemories();
      Get.back();
      Get.toNamed(MemoryScheduledSucceccfully.routeName);
    } catch (e) {
      Get.snackbar("ERROR", e.toString());
    }
  }

  String date = "";
  String time = "";

  String convertDateTime() {
    date =
        "${selectedDate.value.year.toString().padLeft(4, '0')}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}";
    time =
        "${selectedTime.value.hour.toString().padLeft(2, '0')}:${selectedTime.value.minute.toString().padLeft(2, '0')}";

    return "$date $time";
  }

  Future<void> uploadMimeTypes() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));

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
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
      );

      for (int i = 0; i < imageUploadMimType.length; i++) {
        await uploadToS3Bucket(imageUploadMimType[i], i, mimeTypes[i]);
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
      } else {
        ColoredPrint.red("Failed to upload image: ${response?.statusCode}");
      }
    } catch (e) {
      ColoredPrint.red("Error uploading image: $e");
    }
  }

  // Future<void> uploadMedia() async {
  //   Get.dialog(const Center(child: CircularProgressIndicator()));

  //   // ColoredPrint.red("Uploading images to cloud");
  //   // ColoredPrint.magenta(pickedFiles[0].path);
  //   FormData formData = FormData.fromMap({
  //     "images": await Future.wait(pickedFiles.map((file) async {
  //       final fileBytes = await file.readAsBytes();
  //       return MultipartFile.fromBytes(
  //         fileBytes,
  //         filename: file.path.split('/').last,
  //       );
  //     }).toList()),
  //   });

  //   Response? response = await ApiService.postRequest(
  //     ApiConstants.uploadPictures,
  //     formData,
  //   );
  //   ColoredPrint.green(response.toString());
  //   if (response?.statusCode == 201 && response != null) {
  //     imageUploadData = response.data["fileDetails"];
  //     ColoredPrint.green("images Uploded Successfully data: $imageUploadData");
  //     Get.back();
  //     Get.toNamed(WriteAMemoryScreen.routeName);
  //   }
  // }

  Future<void> FetchCategories() async {
    try {
      Response? response =
          await ApiService.getRequest(ApiConstants.getcategories);
      final Map<String, dynamic> jsonMap = jsonDecode(response!.toString());

      //ColoredPrint.green(jsonMap['data']['categories'].toString());
      for (var element in jsonMap['data']['categories']) {
        categories.add(Category.fromJson(element));
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
}

class Recipient {
  TextEditingController emailController;
  TextEditingController contactController;

  TextEditingController relationController;

  Recipient({
    required this.emailController,
    required this.relationController,
    required this.contactController,
  });

  // Method to convert Recipient to a Map
  Map<String, String> toMap() {
    return {
      "email": emailController.text.trim(),
      "contact": contactController.text.trim(),
      "username": emailController.text.trim(),
      "relation": relationController.text.trim(),
    };
  }
}
