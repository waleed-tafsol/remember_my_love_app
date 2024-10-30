import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import '../../../../../constants/assets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  static const routeName = "PrivacyPolicyScreen";

  Future<String> loadTermsAndConditionsHtml() async {
    return await rootBundle.loadString(HtmlAssets.privacy_policy);
  }

  List<Widget> _buildWidgetsFromHtml(String htmlContent, context) {
    final document = parse(htmlContent);
    return document.body?.nodes.map((node) {
          if (node is dom.Element) {
            switch (node.localName) {
              case 'b': // Bold text
                return Text(
                  node.text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                );
              case 'p': // Paragraphs
                return Text(
                  node.text,
                  style: TextStyleConstants.bodyLargeWhite(context),
                );
              case 'ul': // Unordered lists
                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: node.children.map((li) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ", style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: Text(
                            li.text,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              case 'br': // Line breaks
                return k1hSizedBox;
              case 'div': // Divs containing other elements
                return Column(
                    children: _buildWidgetsFromHtml(node.innerHtml, context));
              default:
                return const SizedBox.shrink();
            }
          }
          return const SizedBox.shrink();
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRoundedGlassButton(
                icon: Icons.arrow_back_ios_new_rounded,
                ontap: () => Get.back(),
              ),
              CustomGlassmorphicContainer(
                child: FutureBuilder<String>(
                  future: loadTermsAndConditionsHtml(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Failed to load privacy policy."),
                      );
                    } else {
                      final htmlContent = snapshot.data ?? "";
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildWidgetsFromHtml(htmlContent, context),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
