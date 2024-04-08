import 'package:flutter/material.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import "package:get/get.dart";
import 'home.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorResource.appColor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 150),
            Text(
              "How did we do ?",
              style: headingStyle16MBWhite(),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAll(Home());
                  },
                  iconSize: 45,
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 15),
                IconButton(
                  onPressed: () {
                    Get.offAll(Home());
                  },
                  iconSize: 45,
                  icon: Icon(
                    Icons.thumb_down,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                "Give Feedback on your customer support experience at Portofrutta.com",
                style: headingStyle16MBWhite(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
