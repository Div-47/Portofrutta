import "package:flutter/material.dart" ;

import '../../utility/text_style.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      // width: double.infinity,
      child: Column(
        children: [
          listino(),
        ],
      ),
    );
  }
  Widget listino() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(bottom:15),
            child: Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset("assets/icons/pinneapple.png")),
              SizedBox(
                width: 20,
              ),
              Expanded(
                              child: Text(
                  "Pineapple 1,5kg",
                  style: headingStyle14B(),
                ),
              ),
              manageCart()
            ]),
          );
        });
  }
Widget manageCart() {
    return Container(
      width: 105,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: IntrinsicHeight(
        child: Row(children: [
          Icon(
            Icons.remove,
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 2,
          ),
          Text(
            "10",
            style: headingStyle14B(),
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 2,
          ),
          Icon(Icons.add),
        ]),
      ),
    );
  }



}