import 'package:eshop/modules/login/login_screen.dart';
import 'package:eshop/shared/components/components.dart';
import 'package:eshop/shared/network/local/cashmemory.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class bordingitem {
  final String image;
  final String title;
  final String body;

  bordingitem({required this.image, required this.title, required this.body});
}

class OnBordingScreen extends StatefulWidget {
  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  PageController bordingcontroller = PageController();

  List<bordingitem> items = [
    bordingitem(
        image: "assets/images/onbording1.png",
        title: "Purchase online",
        body:
            "lorem ipsum dolor sit amet ,consect etuer adipi cing elite , set diam nonumy nibih"),
    bordingitem(
        image: "assets/images/onbording2.png",
        title: "Pay",
        body:
            "lorem ipsum dolor sit amet ,consect etuer adipi cing elite , set diam nonumy nibih"),
    bordingitem(
        image: "assets/images/onbording3.png",
        title: "Delivery",
        body:
            "lorem ipsum dolor sit amet ,consect etuer adipi cing elite , set diam nonumy nibih"),
  ];

  bool isfinaish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaulttextbutton(
              onpressed: () {
                CashHelper.setdata(key: "onBording", value: true);
                navigateAndFinish(context, LoginScreen());
              },
              text: "SKIP")
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == items.length - 1) {
                    setState(() {
                      isfinaish = true;
                    });
                  } else {
                    isfinaish = false;
                  }
                },
                controller: bordingcontroller,
                itemBuilder: (context, index) =>
                    build_on_bordaing(context, items[index]),
                itemCount: items.length,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: bordingcontroller,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        activeDotColor: Colors.pinkAccent,
                        dotWidth: 10,
                        spacing: 5),
                    count: items.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isfinaish) {
                       CashHelper.setdata(key: "onBording", value: true).then((value) => navigateAndFinish(context, LoginScreen()));
                      
                    } else {
                      bordingcontroller.nextPage(
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
          ],
        ),
      ),
    );
  }
}

Widget build_on_bordaing(context, bordingitem item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(item.image))),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.title,
          style: TextStyle(fontSize: 25, fontFamily: "Jannah"),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.body,
          style: TextStyle(fontSize: 15, fontFamily: "Jannah"),
        ),
      ),
    ],
  );
}
