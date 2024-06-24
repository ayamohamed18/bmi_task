import 'package:bmi_task/screens/score_screen.dart';
import 'package:bmi_task/widgets/age_weight_widget.dart';
import 'package:bmi_task/widgets/gender_widget.dart';
import 'package:bmi_task/widgets/height_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'dart:math';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});
  static String id = "tracker screen";

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int _gender = 0;
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("BMI Calculator"),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 12,
            shape: const RoundedRectangleBorder(),
            child: Column(children: [
              GenderWidget(
                onChanged: (genderVal) {
                  _gender = genderVal;
                },
              ),
              HeightWidget(
                onChange: (heightVal) {
                  _height = heightVal;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AgeAndWeightWedget(
                      onChange: (weightVal) {
                        _weight = weightVal;
                      },
                      title: "Weight(Kg)",
                      initValue: 30,
                      min: 0,
                      max: 100),
                  AgeAndWeightWedget(
                      onChange: (ageVal) {
                        _age = ageVal;
                      },
                      title: "Age",
                      initValue: 50,
                      min: 0,
                      max: 200),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: SwipeableButtonView(
                    isFinished: _isFinished,
                    onFinish: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                            child: ScoreCreen(bmiScore: _bmiScore, age: _age),
                            type: PageTransitionType.fade),
                      );

                      setState(() {
                        _isFinished = false;
                      });
                    },
                    onWaitingProcess: () {
                      calculateBmi();
                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          _isFinished = true;
                        });
                      });
                    },
                    activeColor: Colors.purple,
                    buttonWidget: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    buttonText: "CALCULATE"),
              ),
            ]),
          ),
        )));
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
  }
}
