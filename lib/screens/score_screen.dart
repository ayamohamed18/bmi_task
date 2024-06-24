import 'package:bmi_task/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class ScoreCreen extends StatelessWidget {
  final double bmiScore;
  final int age;
  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  ScoreCreen({super.key, required this.bmiScore, required this.age});

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      appBar: 
        AppBar(
  title: Text('BMI Score'),
  centerTitle: true,
  actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.logout_outlined,
        color: Colors.black,
      ),
      onPressed: () {
         Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    )
  ],
),
      
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Card(
          elevation: 12,
          shape: const RoundedRectangleBorder(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Your Score",
              style: TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            PrettyGauge(
              gaugeSize: 300,
              minValue: 0,
              maxValue: 40,
              segments: [
                GaugeSegment('UnderWeight', 18.5, Colors.red),
                GaugeSegment('Normal', 6.4, Colors.green),
                GaugeSegment('OverWeight', 5, Colors.orange),
                GaugeSegment('Obesity', 10.1, Colors.pink),
              ],
              valueWidget: Text(
                bmiScore.toStringAsFixed(1),
                style: const TextStyle(fontSize: 40),
              ),
              currentValue: bmiScore.toDouble(),
              needleColor: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              bmiStatus!,
              style: TextStyle(fontSize: 20, color: bmiStatusColor!),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              bmiInterpretation!,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Re-calculate")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Share.share(
                                  "Your BMI is ${bmiScore.toStringAsFixed(1)} at age $age");
                            },
                            child: const Text("Share")),
                      ],),
          ]),
        ),
      ),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.red;
    }
  }
}
