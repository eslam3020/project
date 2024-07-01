import 'package:flutter/material.dart';
import 'package:shadow_clip/shadow_clip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../consts.dart';
import 'login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/beaf-steak.jpg',
        title: 'Choose your favourite dishes',
        body: 'Order now'),
    BoardingModel(
        image: 'assets/images/butter-chicken.jpg',
        title: 'Choose your favourite dishes',
        body: 'Order now'),
    BoardingModel(
        image: 'assets/images/ramen-noodles.jpg',
        title: 'Choose your favourite dishes',
        body: 'Order now'),
  ];

  bool isLast = false;

  void submit() {

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }), (Route<dynamic> route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child:const Text(
              'SKIP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: kPrimaryColor),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                if (value == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              controller: boardController,
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              SmoothPageIndicator(
                controller: boardController,
                effect: const ExpandingDotsEffect(activeDotColor: kPrimaryColor),
                count: boarding.length,
              ),
              const Spacer(),
              FloatingActionButton(backgroundColor: kSecondaryColor,
                onPressed: () {
                  if (isLast) {
                    submit();
                  } else {
                    boardController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                child: const Icon(Icons.arrow_forward_ios,),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipShadow(
            clipper: CliperClass(),
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 10.0,
                color: kPrimaryColor.withOpacity(0.3),
              ),
            ],
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                model.image,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          model.title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(
          model.body,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CliperClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.width);
    path.quadraticBezierTo(
        size.width / 9, size.height, size.width / 4, size.height);
    path.quadraticBezierTo(size.width - (size.width / 2), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
