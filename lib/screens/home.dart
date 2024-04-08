import "package:flutter/material.dart";
import 'package:fruits/controllers/list_controller.dart';
import 'package:fruits/screens/bottomNavigationItems/home_screen.dart';
import 'package:fruits/screens/bottomNavigationItems/list_screen.dart';
import 'package:fruits/screens/bottomNavigationItems/profile_screen.dart';
import 'package:fruits/screens/drawer/cart.dart';
import 'package:fruits/screens/drawer/customer_support.dart';
import 'package:fruits/screens/drawer/order.dart';
import 'package:fruits/screens/login.dart';
import 'package:fruits/screens/search_screen.dart';
import 'package:fruits/screens/user_addresses.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:fruits/widget.dart/text_field_styles.dart';
import "package:get/get.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/box_controller.dart';
import 'bottomNavigationItems/offer_screen.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _controller;
  final listController = Get.put(ListController());
  final boxController = Get.put(BoxController());

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  int _currentIndex = 0;
  var token = '';
  void initState() {
    getToken();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {});
    super.initState();
  }

  getToken() async {
    try {
      token = '';
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        token = prefs.getString("token")!;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        toolbarHeight: _currentIndex == 1 ? 115 : 80,
        centerTitle: true,
        title: boxHeader(),
        backgroundColor: Color(0xffff5340),
        automaticallyImplyLeading: false,
        bottom: _currentIndex == 1
            ? TabBar(
                controller: _controller,
                indicatorColor: Colors.white,
                tabs: [
                    Tab(
                      icon: Icon(Icons.library_books),
                      child: Text(
                        "Listino",
                        style: headingStyle20MBWhite(),
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/icons/box.png",
                        height: 20,
                      ),
                      child: Text(
                        "Box",
                        style: headingStyle20MBWhite(),
                      ),
                    ),
                  ])
            : PreferredSize(
                child: SizedBox(),
                preferredSize: Size(0, 0),
              ),
      ),
      drawer: drawer(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: _currentIndex == 1
            ? Column(children: [
                Visibility(
                  visible: _currentIndex == 1 ? true : false,
                  child: HomeScreen(tabController: _controller),
                ),
              ])
            : SingleChildScrollView(
                child: Column(children: [
                  Visibility(
                    visible: _currentIndex == 0 ? true : false,
                    child: OfferScreen(),
                  ),
                  Visibility(
                    visible: _currentIndex == 3 ? true : false,
                    child: ListScreen(),
                  ),
                  Visibility(
                    visible: _currentIndex == 2 ? true : false,
                    child: ProfileScreen(),
                  )
                ]),
              ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xffff5340),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorResource.white, // This is all you need!
        onTap: (i) async {
          await getToken();
          if (i == 1) {
            setState(() {
              _currentIndex = i;
            });
            listController.fetchList();
            boxController.fetchBox();
          } else if (i == 2) {
            if (token.isEmpty) {
              Get.offAll(LoginScreen());
            } else {
              setState(() {
                _currentIndex = i;
              });
            }
          } else {
            setState(() {
              _currentIndex = i;
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Offers"),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/order.png",
              color: _currentIndex == 1 ? Colors.white : ColorResource.black,
              height: 30,
              width: 30,
            ),
            label: "Order",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ]);
  }

  Widget _searchBox() {
    return Container(
      height: 45,
      width: 280,
      // width: double.infinity,
      child: TextFormField(
        readOnly: true,
        onTap: () {
          Get.to(SearchScreen());
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          hintText: "Search Product",
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffF11515),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Center(child: Image.asset("assets/icons/app_logo.png")),
            Divider(),
            ListTile(
              onTap: () {
                _key.currentState!.closeDrawer();
                token != null && token.isNotEmpty
                    ? Get.to(OrderScreen())
                    : {Get.offAll(LoginScreen())};
              },
              leading: Icon(Icons.local_shipping),
              title: Text(
                "Order",
                style: headingStyle16MBGrey(),
              ),
            ),
            ListTile(
              onTap: () {
                _key.currentState!.closeDrawer();
                Get.to(CartScreen());
              },
              leading: Image.asset("assets/icons/cart.png", color: Colors.grey),
              title: Text(
                "Cart",
                style: headingStyle16MBGrey(),
              ),
            ),
            ListTile(
              onTap: () {
                _key.currentState!.closeDrawer();
                Get.to(UserAddress());
              },
              leading: Icon(Icons.pin_drop, color: Colors.grey),
              title: Text(
                "My Addresses",
                style: headingStyle16MBGrey(),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     _key.currentState!.closeDrawer();
            //     Get.to(CustomerSupportScreen());
            //   },
            //   leading: Icon(Icons.support_agent_sharp),
            //   title: Text(
            //     "Customer Support",
            //     style: headingStyle16MBGrey(),
            //   ),
            // ),
            token != null && token.isNotEmpty
                ? ListTile(
                    leading: Icon(Icons.logout),
                    onTap: () {
                      logout();
                      _key.currentState!.closeDrawer();
                    },
                    title: Text(
                      "Logout",
                      style: headingStyle16MBGrey(),
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.logout),
                    onTap: () {
                      Get.offAll(LoginScreen());
                      _key.currentState!.closeDrawer();
                    },
                    title: Text(
                      "Sign In",
                      style: headingStyle16MBGrey(),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget boxHeader() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer(),

            GestureDetector(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: Image.asset("assets/icons/menu.png",
                  height: 24, width: 24, color: Colors.white),
            ),
            SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Center(
                    child: Text(
                        _currentIndex == 1
                            ? "Fruits And Vegetables"
                            : _currentIndex == 0
                                ? "Offer"
                                : _currentIndex == 2
                                    ? "Profile"
                                    : "Profile",
                        textAlign: TextAlign.center,
                        style: headingStyle20MBWhite()),
                  )),
                  SizedBox(height: 20),
                  _currentIndex == 1
                      ? SizedBox(child: _searchBox())
                      : SizedBox()
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            _currentIndex == 1
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      Get.to(CartScreen());
                    },
                    child: Image.asset("assets/icons/cart.png"))
          ],
        ),
      ],
    );
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginScreen());
  }
}
