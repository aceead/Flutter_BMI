import 'package:flutter/material.dart';
import 'dart:math';
import 'result.dart';

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heightValue = 150.0;
  int age = 20;
  int weightValue = 50;
  double result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Mass Index (BMI)'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    m1Expanded(context, 'm'),
                    SizedBox(
                      width: 15,
                    ),
                    m1Expanded(context, 'f'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Height',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${heightValue.toStringAsFixed(1)}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            ' CM',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Slider(
                        value: heightValue,
                        onChanged: (newValue) {
                          setState(() => heightValue = newValue);
                        },
                        min: 40,
                        max: 240,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    m2Expanded(context, 'w'),
                    SizedBox(
                      width: 15,
                    ),
                    m2Expanded(context, 'a'),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.teal,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 16,
              child: TextButton(
                onPressed: () {
                  result = weightValue / pow(heightValue / 100, 2);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Result(
                        age: age,
                        result: result,
                        isMale: isMale,
                      );
                    },
                  ));
                },
                child: const Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded m1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isMale = (type == 'm') ? true : false),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: (isMale && type == 'm') || (!isMale && type == 'f') ? Colors.teal : Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                type == 'm' ? IconData(0xe3c5, fontFamily: 'MaterialIcons') : IconData(0xe261, fontFamily: 'MaterialIcons'),
                color: Colors.white,
                size: 90.0,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                type == 'm' ? "Male" : 'Female',
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              type == 'w' ? "Weight" : 'Age',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              type == 'w' ? '$weightValue' : '$age',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: type == 'w' ? 'weight--' : 'age--',
                  onPressed: () => setState(() => type == 'w' ? weightValue-- : age--),
                  child: Icon(Icons.remove),
                  mini: true,
                ),
                SizedBox(
                  width: 8,
                ),
                FloatingActionButton(
                  heroTag: type == 'w' ? 'weight++' : 'age++',
                  onPressed: () => setState(() => type == 'w' ? weightValue++ : age++),
                  child: Icon(Icons.add),
                  mini: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
