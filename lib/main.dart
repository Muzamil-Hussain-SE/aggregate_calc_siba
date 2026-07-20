import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  @override
  String toString() => '$programName ($dept) — Merit: $merit';

  void checkMerit(int marks) {
    newList.clear();
    for (var i = 0; i < programs.length; i++) {
      // print(programs[i].programName);
      if (marks >= programs[i].merit) {
        newList.add(programs[i]);
      } else if (marks < 51) {
        newList.clear();
        break;
      }
    }
    print(newList);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  int _number = 0;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade700),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: (w <= 411 && h <= 937)
                  ? Mobileui()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (w <= 411 && h <= 937)
                            ? SizedBox(width: 100)
                            : SizedBox(width: 50),
                        (w <= 411 && h <= 937)
                            ? Container(
                                height: 150,
                                width: 175,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 85.0,
                                            vertical: 70.0,
                                          ),
                                          child: Container(
                                            height: 100,
                                            width: 95,

                                            child: Image.asset(
                                              'assets/sibalogo.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Admission',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Predictor',
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
                                    Form(
                                      key: _key,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 65.0,
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          decoration: InputDecoration(
                                            label: Text('Your Score'),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter Your Score';
                                            } else if (int.parse(value) > 100) {
                                              return 'Marks must be less than 100';
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) {
                                            setState(() {
                                              _number =
                                                  int.tryParse(
                                                    newValue ?? '',
                                                  ) ??
                                                  0;
                                            });
                                            print(_number);
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 25.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 175.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            if (_key.currentState?.validate() ??
                                                false) {
                                              _key.currentState?.save();
                                            }
                                            Predictor pred = Predictor(
                                              programName: 'BSCS',
                                              dept: 'CS',
                                              merit: _number,
                                            );
                                            pred.checkMerit(_number);
                                            _checked = true;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: Colors.cyan.shade700,
                                            borderRadius: BorderRadius.circular(
                                              12.0,
                                            ),
                                          ),
                                          child: Text(
                                            'Check',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) // mobile ends here
                            : //web
                              Container(
                                height: 425,
                                width: 425,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 85.0,
                                            vertical: 70.0,
                                          ),
                                          child: Container(
                                            height: 100,
                                            width: 95,

                                            child: Image.asset(
                                              'assets/sibalogo.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Admission',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Predictor',
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
                                    Form(
                                      key: _key,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 65.0,
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          decoration: InputDecoration(
                                            label: Text('Your Score'),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter Your Score';
                                            } else if (int.parse(value) > 100) {
                                              return 'Marks must be less than 100';
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) {
                                            setState(() {
                                              _number =
                                                  int.tryParse(
                                                    newValue ?? '',
                                                  ) ??
                                                  0;
                                            });
                                            print(_number);
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 25.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 175.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            if (_key.currentState?.validate() ??
                                                false) {
                                              _key.currentState?.save();
                                            }
                                            Predictor pred = Predictor(
                                              programName: 'BSCS',
                                              dept: 'CS',
                                              merit: _number,
                                            );
                                            pred.checkMerit(_number);
                                            _checked = true;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: Colors.cyan.shade700,
                                            borderRadius: BorderRadius.circular(
                                              12.0,
                                            ),
                                          ),
                                          child: Text(
                                            'Check',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(width: 200),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 120),
                            Text(
                              'Admission Possible in',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            Text(
                              'following Programs:',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              height: 250,
                              width: 350,
                              child: !_checked
                                  ? Text(
                                      'Enter score, tap and check',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: newList.isEmpty
                                          ? 1
                                          : newList.length,
                                      itemBuilder: (context, index) {
                                        return newList.isEmpty
                                            ? Text(
                                                'Admission not possible yet.You can wait for the next merit list',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                newList[index].programName,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Mobileui extends StatefulWidget {
  @override
  State<Mobileui> createState() => _MobileuiState();
}

int _number = 0;
final _key = GlobalKey<FormState>();

class _MobileuiState extends State<Mobileui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Container(
                  height: 500,
                  width: 300,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset(
                          'assets/sibalogo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Admission Predictor',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Form(
                        key: _key,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 90.0,
                          ),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              label: Text('Your Score'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your Score';
                              } else if (int.parse(value) > 100) {
                                return 'Marks must be less than 100';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                                _number = int.tryParse(newValue ?? '') ?? 0;
                              });
                              print(_number);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 110.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              if (_key.currentState?.validate() ?? false) {
                                _key.currentState?.save();
                              }
                              Predictor pred = Predictor(
                                programName: 'BSCS',
                                dept: 'CS',
                                merit: _number,
                              );
                              pred.checkMerit(_number);
                              _checked = true;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.cyan.shade700,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              'Check',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 200),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Admission Possible in',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      'following Programs:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: !_checked
                          ? Text(
                              'Enter score, tap and check',
                              style: TextStyle(color: Colors.white),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: newList.isEmpty ? 1 : newList.length,
                              itemBuilder: (context, index) {
                                return newList.isEmpty
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Admission not possible yet.You can wait for the next merit list',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : Text(
                                        newList[index].programName,
                                        style: TextStyle(color: Colors.white),
                                      );
                              },
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
