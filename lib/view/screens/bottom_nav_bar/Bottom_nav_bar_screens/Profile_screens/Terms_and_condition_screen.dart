import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:remember_my_love_app/constants/assets.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../widgets/Custom_glass_container.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/custom_scaffold.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});
  static const routeName = "TermsAndConditionScreen";
  Future<String> loadPrivacyPolicyHtml() async {
    return await rootBundle.loadString(HtmlAssets.terms_and_conditions);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRoundedGlassButton(
              icon: Icons.arrow_back_ios_new_rounded,
              ontap: () => Get.back(),
            ),
            CustomGlassmorphicContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String>(
                  future: loadPrivacyPolicyHtml(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Failed to load Terms and Conditions."),
                      );
                    } else {
                      final document = parse(snapshot.data);
                      final widgetList = document.body!.nodes.map((node) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case 'h1':
                              return Text(
                                node.text,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              );
                            case 'h2':
                              return Text(
                                node.text,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              );
                            case 'p':
                              return Text(
                                node.text,
                                style: TextStyle(fontSize: 16, height: 1.5),
                              );
                            case 'ul':
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: node.children.map((li) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("• ",
                                          style: TextStyle(fontSize: 16)),
                                      Expanded(
                                        child: Text(
                                          li.text,
                                          style: TextStyle(
                                              fontSize: 16, height: 1.5),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            default:
                              return SizedBox.shrink();
                          }
                        }
                        return SizedBox.shrink();
                      }).toList();

                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widgetList,
                        ),
                      );
                    }
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
