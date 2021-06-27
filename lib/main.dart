import 'dart:math';
import 'package:book_of_excuses/excuses.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int randInt = Random().nextInt(excuses.length);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation); //initialize SizerUtil
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sizer',
              theme: ThemeData.dark(),
              home: SafeArea(
                child: Scaffold(
                  backgroundColor: bgColor,
                  body: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 2.0.h),
                            child: Center(
                              child: Text(
                                "Book of Excuses",
                                style: GoogleFonts.asul(
                                  textStyle: TextStyle(
                                      fontSize: 30.0.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 30.0.h, right: 2.0.h, left: 2.0.h),
                            child: Center(
                              child: AnimatedSwitcher(
                                switchInCurve: Curves.fastLinearToSlowEaseIn,
                                switchOutCurve: Curves.fastLinearToSlowEaseIn,
                                duration: const Duration(milliseconds: 600),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      child: child, scale: animation);
                                },
                                child: textWidget1(
                                  randInt: randInt,
                                  key: ValueKey<int>(randInt),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: firstColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0.h)),
                              border: Border.all(
                                width: 0.90.h,
                                color: secondColor,
                              ),
                            ),
                            padding: EdgeInsets.all(2.0.h),
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0.h, horizontal: 10.0.h),
                            child: InkWell(
                              onTap: () {
                                Vibration.vibrate(duration: 10);
                                setState(() {
                                  randInt = Random().nextInt(excuses.length);
                                });
                                print('Pressed 2');
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                  child: Text(
                                    "Click here for another Excuse",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.asul(
                                      textStyle: TextStyle(
                                          fontSize: 15.0.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class textWidget1 extends StatelessWidget {
  const textWidget1({
    Key key,
    @required this.randInt,
  }) : super(key: key);

  final int randInt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.0.h),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.all(Radius.circular(3.0.h)),
        border: Border.all(
          width: 0.90.h,
          color: firstColor,
        ),
      ),
      child: InkWell(
        onTap: () async {
          Vibration.vibrate(duration: 10);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'copied "${excuses[randInt].toUpperCase()}"',
              ),
              duration: Duration(milliseconds: 300),
            ),
          );
          Clipboard.setData(
            new ClipboardData(
              text: excuses[randInt].toLowerCase(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(1.0.h),
          child: Column(
            children: [
              Text(
                excuses[randInt].toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.asul(
                  textStyle: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 2.0.h),
              Icon(
                Icons.copy_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
