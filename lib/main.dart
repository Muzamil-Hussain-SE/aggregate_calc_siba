import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

bool _checked = false;

List<Predictor> programs = [
  Predictor(
    programName: 'BS Computer Science',
    dept: 'Department of Computer Science',
    merit: 82,
  ),
  Predictor(
    programName: 'BS Artificial Intelligence',
    dept: 'Department of Computer Science',
    merit: 85,
  ),
  Predictor(
    programName: 'BS Software Engineering',
    dept: 'Department of Computer Science',
    merit: 78,
  ),
  Predictor(
    programName: 'BS Accounting & Finance',
    dept: 'Department of Business Administration',
    merit: 75,
  ),
  Predictor(
    programName: 'BBA (Marketing / HRM / Finance)',
    dept: 'Department of Business Administration',
    merit: 72,
  ),
  Predictor(
    programName: 'BE Electrical Engineering',
    dept: 'Department of Electrical Engineering',
    merit: 68,
  ),
  Predictor(
    programName: 'BE Computer System Engineering',
    dept: 'Department of Computer System Engineering',
    merit: 66,
  ),
  Predictor(
    programName: 'BBA (Agribusiness)',
    dept: 'Department of Business Administration',
    merit: 65,
  ),
  Predictor(
    programName: 'BS Mathematics',
    dept: 'Department of Mathematics',
    merit: 60,
  ),
  Predictor(
    programName: 'BS Economics',
    dept: 'Department of Business Administration',
    merit: 58,
  ),
  Predictor(
    programName: 'BS Media & Communication',
    dept: 'Department of Media & Communication',
    merit: 57,
  ),
  Predictor(
    programName: 'B.Ed (Hons) - Elementary',
    dept: 'Department of Education',
    merit: 55,
  ),
  Predictor(
    programName: 'B.Ed 2.5 Years (Extension)',
    dept: 'Department of Education',
    merit: 53,
  ),
  Predictor(
    programName: 'BS Physical Education',
    dept: 'Department of Physical Education',
    merit: 53,
  ),
  Predictor(
    programName: 'Associate Degree - Physical Education',
    dept: 'Department of Physical Education',
    merit: 51,
  ),
];
List<Predictor> newList = [];

class Predictor {
  int marks = 0;

  String programName = '';
  String dept = '';
  int merit = 0;
  Predictor({
    required this.programName,
    required this.dept,
    required this.merit,
  });
}

void checkMerit(int marks) {
  newList.clear();
  for (var i = 0; i < programs.length; i++) {
    // print(programs[i].programName);
    if (marks >= programs[i].merit) {
      newList.add(programs[i]);
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: "SIBA Admission Predictor",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade700),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.black,
                      const Color.fromARGB(255, 1, 28, 74),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: w >= h
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 40),
                                    Image.network(
                                      "https://i.ibb.co/XxMB0zhZ/sibalogo.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text(
                                      "Admission Predictor",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Enter your test score",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Form(
                                  key: _key,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 280,
                                        height: 80,
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            label: Text(
                                              "Test Score",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                  255,
                                                  0,
                                                  115,
                                                  192,
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                            ),
                                          ),
                                          style: TextStyle(color: Colors.white),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Required field";
                                            } else if (int.tryParse(value)! >
                                                100) {
                                              return 'Marks must be less than 100';
                                            }

                                            return null;
                                          },
                                          onSaved: (newValue) {
                                            setState(() {
                                              checkMerit(int.parse(newValue!));
                                              _checked = true;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      InkWell(
                                        onTap: () {
                                          if (_key.currentState!.validate()) {
                                            _key.currentState!.save();
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color.fromARGB(
                                                  255,
                                                  2,
                                                  67,
                                                  121,
                                                ),
                                                const Color.fromARGB(
                                                  255,
                                                  1,
                                                  1,
                                                  79,
                                                ),
                                                const Color.fromARGB(
                                                  255,
                                                  6,
                                                  1,
                                                  168,
                                                ),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              360,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Check",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: _checked
                                ? newList.length == 0
                                      ? Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Text(
                                            "Sorry admission not possible in any program, better luck next time",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 400,
                                          height: 400,
                                          child: ListView.builder(
                                            itemCount: newList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 3.0,
                                                ),
                                                width: 380,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.0,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Text(
                                                    "${newList[index].programName} ${newList[index].dept}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                : Text(
                                    "Please enter your marks",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              width: 330,
                              height: 300,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 40),
                                      Image.network(
                                        "https://i.ibb.co/XxMB0zhZ/sibalogo.png",
                                        width: 100,
                                        height: 100,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Admission",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            "Predictor",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Enter your test score",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Form(
                                    key: _key,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 280,
                                          height: 80,
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.numberWithOptions(),
                                            decoration: InputDecoration(
                                              label: Text(
                                                "Test Score",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    0,
                                                    115,
                                                    192,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Required field";
                                              } else if (int.tryParse(value)! >
                                                  100) {
                                                return 'Marks must be less than 100';
                                              }
                                              return null;
                                            },
                                            onSaved: (newValue) {
                                              setState(() {
                                                checkMerit(
                                                  int.parse(newValue!),
                                                );
                                                _checked = true;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            if (_key.currentState!.validate()) {
                                              _key.currentState!.save();
                                            }
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color.fromARGB(
                                                    255,
                                                    2,
                                                    67,
                                                    121,
                                                  ),
                                                  const Color.fromARGB(
                                                    255,
                                                    1,
                                                    1,
                                                    79,
                                                  ),
                                                  const Color.fromARGB(
                                                    255,
                                                    6,
                                                    1,
                                                    168,
                                                  ),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Check",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 330,
                              height: 400,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: _checked
                                  ? newList.length == 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Text(
                                              "Sorry admission not possible in any program, better luck next time",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            width: 370,
                                            height: 400,
                                            child: ListView.builder(
                                              itemCount: newList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 3.0,
                                                  ),
                                                  width: 350,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Text(
                                                      "${newList[index].programName} ${newList[index].dept}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                  : Text(
                                      "Please enter your marks",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
