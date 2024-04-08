import "package:flutter/material.dart" ;
import 'package:fruits/utility/colors.dart';

class CustomerSupportScreen extends StatefulWidget {
  CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: ColorResource.appColor,
        title:Text("Customer Support")
      ),
    );
  }
}