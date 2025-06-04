import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import '../../constants/ApiConstant.dart';
import '../../models/SearchUserModel.dart';
import '../../services/ApiServices.dart';

class EmailSearchField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const EmailSearchField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<EmailSearchField> createState() => _EmailSearchFieldState();
}

class _EmailSearchFieldState extends State<EmailSearchField> {
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  Timer? _debounce;
  List<String> _emailSuggestions = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _insertOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  void _onTextChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await _fetchEmails(query);
      setState(() {
        _emailSuggestions = results ?? [];
        _overlayEntry?.markNeedsBuild();
      });
    });
  }

  void _insertOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _buildOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _buildOverlayEntry() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Size size = box.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _emailSuggestions.length,
              itemBuilder: (context, index) {
                final email = _emailSuggestions[index];
                return ListTile(
                  title: Text(email),
                  onTap: () {
                    widget.controller.text = email;
                    _removeOverlay();
                    FocusScope.of(context).unfocus();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Enter Email',
          suffixIcon: Icon(Icons.email),
        ),
        onChanged: _onTextChanged,
      ),
    );
  }

  /// Simulated API fetch for matching emails
  // Future<List<String>> _fetchEmails(String query) async {
  //   await Future.delayed(const Duration(milliseconds: 300)); // Simulate delay

  //   // Dummy data – replace with your API call
  //   const allEmails = [
  //     'john@example.com',
  //     'jane@example.com',
  //     'admin@example.com',
  //     'user@example.com',
  //   ];

  //   return allEmails
  //       .where((email) => email.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }

  Future<List<String>?> _fetchEmails(String? email) async {
    try {
      Response? response = await ApiService.getRequest(
        ApiConstants.getAvailableUsers,
        queryParameters: {
          "search": email ?? "",
        },
      );

      if (response?.data != null && response?.data["data"] != null) {
        var userList = response?.data["data"]["user"];
        if (userList is List) {
          final allEmails =
              userList.map<String>((user) => user["email"]).toList();

          return allEmails;
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
}
