import 'dart:convert';
import 'dart:io';
import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
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
import '../models/categories.dart';
import '../services/MemoryServices.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Memory_scheduled_succeccfully.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Write_a_memory.dart';

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
  List<dynamic> successFullFilesUploads = [];

  @override
  void onInit() async {
    super.onInit();
    await FetchCategories();
    recipients.add(Recipient(
        emailController: TextEditingController(),
        contactController: TextEditingController()));
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
        contactController: TextEditingController()));
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
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        pickedFiles.add(File(file.path)); // Add picked file to the list
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image or video: $e');
    }
  }
  void getFileExtension(String fileName) {
    final String mimeType =  ".${fileName.split('.').last}".toLowerCase();
    print(mimeType);
  }
  Future<void> takePhotoOrVideo() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        pickedFiles.add(File(file.path));
        getFileExtension(file.path);

        uploadFileToS3(File(file.path),"https://remember-my-love-bucket.s3.amazonaws.com/c5ac8615-bba8-4c53-83e0-1c76eb26ff1e.image/jpeg?AWSAccessKeyId=AKIA2NK3X2IRTDNYCDZM&Content-Type=image%2Fjpeg&Expires=1732943348&Signature=yrEDbC%2BBXROY8gesSfTlT4NqKOk%3D");

      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to take photo or video: $e');
    }
  }

  Future<void> uploadFileToS3(File file, String presignedUrl) async {
    try {
      Dio dio = Dio();

      // Open the file as a stream
      var stream = file.openRead();
      var length = await file.length();

      Response response = await dio.put(
        presignedUrl,
        data: stream,
        options: Options(
          headers: {
            'Content-Type':
            'image/jpg', // Content-Type for binary data
            'Content-Length':
            length, // Important for setting the correct file length
          },
        ),
      );

      if (response.statusCode == 200) {
        print('File uploaded successfully.');
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    }  catch (e) {
      print('Unexpected error: $e');
    }
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
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    try {
      convertDateTime();
      await Memoryservices.create_mem(
          title: titleController.value.text,
          description: descriptionController.value.text,
          category: selectedCatagory.value?.sId ?? "",
          deliveryDate: date,
          deliveryTime: time,
          sendTo: sendTo.string,
          receivingUserName: recievingUsername.value.text,
          receivingUserPassword: recievingUserPassword.value.text,
          recipients: recipients.map((recipient) => recipient.toMap()).toList(),
          recipientsRelation: recipientRelation.value.text.trim(),
          files: []
          // imageUploadData
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
      // Assuming pickedFiles[i] is your selected file
      final file = pickedFiles[i];
      final fileBytes = await file.readAsBytes();

      // Prepare FormData with the key and file
      // final imageBytes = await MultipartFile.fromBytes(
      //   fileBytes,
      //   filename: file.path.split('/').last,
      // );

      // Upload the file using the put req

      final response = await Dio().put(
        imageMap["url"],
        data: fileBytes,
        options: Options(
          headers: {
            "Content-Type": mimeType,
          },
        ),
      );

      // Handle the response
      if (response?.statusCode == 200 && response != null) {
        // successFullFilesUploads.add(response.data["fileDetails"]);
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

  Recipient({required this.emailController, required this.contactController});

  // Method to convert Recipient to a Map
  Map<String, String> toMap() {
    return {
      "email": emailController.text.trim(),
      "contact": contactController.text.trim(),
    };
  }
}
