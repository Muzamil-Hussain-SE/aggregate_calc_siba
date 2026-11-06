import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// ---------- Glass palette: vivid backdrop, frosted white surfaces ----------
const deep = Color(0xFF0B1030);
const violet = Color(0xFF7C4DFF);
const aqua = Color(0xFF22D3EE);
const rose = Color(0xFFFF5C93);
const amber = Color(0xFFFFB86B);

const logoUrl = "https://i.ibb.co/XxMB0zhZ/sibalogo.png";

class Predictor {
  final String programName;
  final String dept;
  final int merit;
  const Predictor(this.programName, this.dept, this.merit);
}

const programs = <Predictor>[
  Predictor('BS Computer Science', 'Department of Computer Science', 64),
  Predictor('BS Artificial Intelligence', 'Department of Computer Science', 63),
  Predictor('BS Software Engineering', 'Department of Computer Science', 61),
  Predictor(
    'BS Accounting & Finance',
    'Department of Business Administration',
    58,
  ),
  Predictor(
    'BBA (Marketing / HRM / Finance)',
    'Department of Business Administration',
    52,
  ),
  Predictor(
    'BE Electrical Engineering',
    'Department of Electrical Engineering',
    40,
  ),
  Predictor(
    'BE Computer System Engineering',
    'Department of Computer System Engineering',
    42,
  ),
  Predictor('BBA (Agribusiness)', 'Department of Business Administration', 41),
  Predictor('BS Mathematics', 'Department of Mathematics', 40),
  Predictor('BS Economics', 'Department of Business Administration', 40),
  Predictor(
    'BS Media & Communication',
    'Department of Media & Communication',
    43,
  ),
  Predictor('B.Ed (Hons) - Elementary', 'Department of Education', 44),
  Predictor('B.Ed 2.5 Years (Extension)', 'Department of Education', 44),
  Predictor('BS Physical Education', 'Department of Physical Education', 40),
  Predictor(
    'Associate Degree - Physical Education',
    'Department of Physical Education',
    40,
  ),
];

List<Predictor> checkMerit(int marks) =>
    programs.where((p) => marks >= p.merit).toList();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SIBA Admission Predictor",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: violet,
          brightness: Brightness.dark,
        ),
      ),
      home: const PredictorPage(),
    );
  }
}

class PredictorPage extends StatefulWidget {
  const PredictorPage({super.key});

  @override
  State<PredictorPage> createState() => _PredictorPageState();
}

class _PredictorPageState extends State<PredictorPage> {
  final _key = GlobalKey<FormState>();
  bool _checked = false;
  List<Predictor> _matches = [];

  void _submit() {
    if (_key.currentState!.validate()) _key.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deep,
      body: Stack(
        children: [
          const Positioned.fill(child: _Backdrop()),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, c) {
                final wide = c.maxWidth >= 900;
                final input = _inputCard();
                final result = _resultCard();
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        wide
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 420, child: input),
                                  const SizedBox(width: 28),
                                  SizedBox(width: 420, child: result),
                                ],
                              )
                            : ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 420,
                                ),
                                child: Column(
                                  children: [
                                    input,
                                    const SizedBox(height: 24),
                                    result,
                                  ],
                                ),
                              ),
                        const SizedBox(height: 28),
                        const Glass(
                          radius: 360,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite_rounded,
                                size: 15,
                                color: rose,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Made by Muzamil Hussain",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputCard() {
    return Glass(
      padding: const EdgeInsets.all(26),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: aqua.withOpacity(0.5), blurRadius: 22),
                  ],
                ),
                child: Image.network(
                  logoUrl,
                  width: 52,
                  height: 52,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.school_rounded, size: 52, color: deep),
                ),
              ),
              const SizedBox(width: 16),
              const Flexible(
                child: Text(
                  "Admission\nPredictor",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const Text(
            "Enter your test score",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 14),
          Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorColor: aqua,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelText: "Test score (0 to 100)",
                    labelStyle: const TextStyle(color: Colors.white60),
                    floatingLabelStyle: const TextStyle(color: aqua),
                    errorStyle: const TextStyle(color: amber),
                    border: _field(Colors.white30),
                    enabledBorder: _field(Colors.white30),
                    focusedBorder: _field(aqua, 1.8),
                    errorBorder: _field(amber),
                    focusedErrorBorder: _field(amber, 1.8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required field";
                    final n = int.tryParse(value);
                    if (n == null || n > 100)
                      return "Enter marks from 0 to 100";
                    return null;
                  },
                  onSaved: (v) => setState(() {
                    _matches = checkMerit(int.parse(v!));
                    _checked = true;
                  }),
                ),
                const SizedBox(height: 22),
                _button(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _field(Color c, [double w = 1]) => OutlineInputBorder(
    borderSide: BorderSide(color: c, width: w),
    borderRadius: BorderRadius.circular(18),
  );

  Widget _button() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        gradient: LinearGradient(
          colors: [aqua.withOpacity(0.75), violet.withOpacity(0.75)],
        ),
        border: Border.all(color: Colors.white38),
        boxShadow: [BoxShadow(color: violet.withOpacity(0.45), blurRadius: 22)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(360),
          onTap: _submit,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            child: Text(
              "Check",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultCard() {
    return Glass(
      padding: const EdgeInsets.all(22),
      child: SizedBox(
        height: 420,
        child: !_checked
            ? const _Message(
                icon: Icons.auto_awesome_rounded,
                title: "Your matches appear here",
                body: "Enter your marks and tap Check.",
              )
            : _matches.isEmpty
            ? const _Message(
                icon: Icons.search_off_rounded,
                title: "No program matches yet",
                body: "Retake the test or check the next admission cycle.",
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_matches.length} ${_matches.length == 1 ? 'program' : 'programs'} match your score",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _matches.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) => _tile(_matches[i]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _tile(Predictor p) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.programName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  p.dept.replaceFirst('Department of ', ''),
                  style: const TextStyle(color: Colors.white60, fontSize: 12.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: aqua.withOpacity(0.18),
              borderRadius: BorderRadius.circular(360),
              border: Border.all(color: aqua.withOpacity(0.5)),
            ),
            child: Text(
              "${p.merit}",
              style: const TextStyle(color: aqua, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Reusable pieces ----------
class Glass extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  const Glass({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.radius = 32,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(radius);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: r,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: r,
              border: Border.all(
                color: Colors.white.withOpacity(0.28),
                width: 1.2,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.22),
                  Colors.white.withOpacity(0.06),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final IconData icon;
  final String title, body;
  const _Message({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 56, color: Colors.white54),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _Backdrop extends StatelessWidget {
  const _Backdrop();

  Widget _orb(Color c, double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(colors: [c.withOpacity(0.85), c.withOpacity(0)]),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: deep,
      child: Stack(
        children: [
          Positioned(left: -120, top: -80, child: _orb(violet, 560)),
          Positioned(right: -140, top: 120, child: _orb(rose, 480)),
          Positioned(left: 80, bottom: -200, child: _orb(aqua, 620)),
        ],
      ),
    );
  }
}
