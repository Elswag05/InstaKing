import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/navigation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:insta_king/presentation/views/onboarding/insta_onboarding_content.dart';
import 'package:insta_king/presentation/views/onboarding/size_config.dart';

class InstaOnboarding extends StatefulWidget {
  const InstaOnboarding({super.key});

  @override
  State<InstaOnboarding> createState() => _InstaOnboardingState();
}

class _InstaOnboardingState extends State<InstaOnboarding> {
  late PageController _controller;
  late SharedPreferences _prefs;
  // ignore: unused_field
  bool _showOnboarding = true; // Default to show onboarding

  @override
  void initState() {
    _controller = PageController();
    _initPrefs();
    super.initState();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _showOnboarding = _prefs.getBool('showOnboarding') ?? true;
    });
  }

  void _setOnboardingComplete() {
    _prefs.setBool('showOnboarding', false);
  }

  int _currentPage = 0;
  List colors = const [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 218, 203, 230),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Theme.of(context).primaryColor,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      curve: Curves.easeIn,
      width: _currentPage == index ? 25 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    // double height = SizeConfig.screenH!;
    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents
                    .length, // Ensure this matches the length of your contents list
                itemBuilder: (context, i) {
                  return Stack(
                    children: [
                      Container(
                        height: 370.h,
                        width: double.infinity,
                        color: i == 0 ? Colors.green : InstaColors.primaryColor,
                        child: Image.asset(
                          contents[i].image,
                          height: 300.h,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 350.h,
                            ),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Montesserat',
                                fontWeight: FontWeight.w600,
                                fontSize: (width <= 550) ? 25.sp : 30.sp,
                                color: Theme.of(context).colorScheme.scrim,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              contents[i].desc,
                              style: TextStyle(
                                fontFamily: 'Montesserat',
                                fontWeight: FontWeight.w300,
                                fontSize:   15.sp,
                                color: Theme.of(context).colorScheme.scrim,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: ElevatedButton(
                            onPressed: () {
                              _setOnboardingComplete();
                              // Navigate to the next screen after onboarding completion
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const InstaAuthNavigator(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: (width <= 550)
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 20)
                                  : EdgeInsets.symmetric(
                                      horizontal: width * 0.2, vertical: 25),
                              textStyle:
                                  TextStyle(fontSize: (width <= 550) ? 13 : 17),
                            ),
                            child: Text(
                              "GET STARTED",
                              style: TextStyle(
                                fontFamily: 'Montesserat',
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: (width <= 550) ? 13 : 17,
                                  ),
                                ),
                                child: const Text(
                                  "SKIP",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montesserat',
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                  padding: (width <= 550)
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 25),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17),
                                ),
                                child: const Text(
                                  "NEXT",
                                  style: TextStyle(
                                    color: InstaColors.lightColor,
                                    fontFamily: 'Montesserat',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
