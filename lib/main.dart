import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(const MyApp());

// ---------- Maximal palette ----------
const ink = Color(0xFF14002E);
const plum = Color(0xFF3B0A6B);
const hotPink = Color(0xFFFF2E93);
const sun = Color(0xFFFFC93C);
const aqua = Color(0xFF00E5FF);
const lime = Color(0xFFB6FF3B);
const coral = Color(0xFFFF6B4A);
const tileColors = [hotPink, sun, aqua, lime, coral];

const logoUrl = "https://i.ibb.co/XxMB0zhZ/sibalogo.png";

// ---------- Data ----------
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

IconData iconFor(String dept) {
  if (dept.contains('Computer')) return Icons.memory_rounded;
  if (dept.contains('Business')) return Icons.trending_up_rounded;
  if (dept.contains('Electrical')) return Icons.bolt_rounded;
  if (dept.contains('Math')) return Icons.functions_rounded;
  if (dept.contains('Media')) return Icons.podcasts_rounded;
  if (dept.contains('Education')) return Icons.menu_book_rounded;
  return Icons.sports_soccer_rounded;
}

// ---------- App ----------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SIBA Admission Predictor",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: hotPink,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ink,
              Color(0xFF2A0657),
              Color(0xFF5A0F6E),
              Color(0xFF01274F),
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned.fill(
              child: RepaintBoundary(child: CustomPaint(painter: BgPainter())),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, c) {
                  final wide = c.maxWidth >= 900;
                  final inputCard = _inputCard();
                  final resultCard = _resultCard();
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
                                    SizedBox(width: 430, child: inputCard),
                                    const SizedBox(width: 36),
                                    SizedBox(width: 430, child: resultCard),
                                  ],
                                )
                              : ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 430,
                                  ),
                                  child: Column(
                                    children: [
                                      inputCard,
                                      const SizedBox(height: 32),
                                      resultCard,
                                    ],
                                  ),
                                ),
                          const SizedBox(height: 34),
                          const CreditFooter(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Input card ----------
  Widget _inputCard() {
    return PopCard(
      color: plum,
      shadow: hotPink,
      angle: -0.012,
      child: Column(
        children: [
          _header(),
          const SizedBox(height: 20),
          const Text(
            "Enter your test score",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelText: "Test score (0 to 100)",
                    labelStyle: const TextStyle(
                      color: sun,
                      fontWeight: FontWeight.w700,
                    ),
                    errorStyle: const TextStyle(
                      color: lime,
                      fontWeight: FontWeight.w700,
                    ),
                    prefixIcon: const Icon(
                      Icons.edit_note_rounded,
                      color: aqua,
                    ),
                    border: _field(Colors.white),
                    enabledBorder: _field(sun),
                    focusedBorder: _field(aqua, 4),
                    errorBorder: _field(lime),
                    focusedErrorBorder: _field(lime, 4),
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
                _checkButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _field(Color c, [double w = 3]) => OutlineInputBorder(
    borderSide: BorderSide(color: c, width: w),
    borderRadius: BorderRadius.circular(360),
  );

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: sun, width: 4),
            boxShadow: const [BoxShadow(color: aqua, offset: Offset(6, 6))],
          ),
          child: Image.network(
            logoUrl,
            width: 64,
            height: 64,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.school_rounded, size: 64, color: ink),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Admission",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -1,
                ),
              ),
              AnimatedTextKit(
                repeatForever: true,
                isRepeatingAnimation: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Predictor",
                    textStyle: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -1.5,
                    ),
                    colors: const [sun, hotPink, aqua, lime, sun],
                    speed: const Duration(milliseconds: 350),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _checkButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        border: Border.all(color: Colors.white, width: 3),
        gradient: const LinearGradient(colors: [hotPink, coral, sun]),
        boxShadow: const [BoxShadow(color: ink, offset: Offset(6, 6))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(360),
          onTap: _submit,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 34, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome_rounded, color: ink),
                SizedBox(width: 10),
                Text(
                  "Check my programs",
                  style: TextStyle(
                    color: ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Result card ----------
  Widget _resultCard() {
    return PopCard(
      color: const Color(0xFF05324F),
      shadow: aqua,
      angle: 0.012,
      child: SizedBox(
        height: 430,
        child: !_checked
            ? const _Message(
                icon: Icons.rocket_launch_rounded,
                color: sun,
                title: "Your matches land here",
                body:
                    "Enter your marks and tap Check to see every program you qualify for.",
              )
            : _matches.isEmpty
            ? _Message(
                icon: Icons.sentiment_dissatisfied_rounded,
                color: coral,
                title: "No program matches yet",
                body:
                    "The lowest merit is ${programs.map((p) => p.merit).reduce((a, b) => a < b ? a : b)} marks. Retake the test or check the next admission cycle.",
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: lime,
                      borderRadius: BorderRadius.circular(360),
                      border: Border.all(color: ink, width: 3),
                    ),
                    child: Text(
                      "You qualify for ${_matches.length} ${_matches.length == 1 ? 'program' : 'programs'}",
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _matches.length,
                      itemBuilder: (context, i) => _tile(_matches[i], i),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _tile(Predictor p, int i) {
    final c = tileColors[i % tileColors.length];
    return Transform.rotate(
      angle: i.isEven ? -0.012 : 0.012,
      child: Container(
        margin: const EdgeInsets.fromLTRB(4, 6, 10, 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: ink, width: 3),
          boxShadow: const [BoxShadow(color: ink, offset: Offset(5, 5))],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: ink,
              child: Icon(iconFor(p.dept), color: c),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.programName,
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    p.dept.replaceFirst('Department of ', ''),
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(360),
                border: Border.all(color: ink, width: 2),
              ),
              child: Text(
                "Merit ${p.merit}",
                style: const TextStyle(
                  color: ink,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Reusable pieces ----------
class _Message extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, body;
  const _Message({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 72, color: color),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class PopCard extends StatelessWidget {
  final Color color, shadow;
  final double angle;
  final Widget child;
  const PopCard({
    super.key,
    required this.color,
    required this.shadow,
    required this.angle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(color: shadow, offset: const Offset(10, 10)),
            BoxShadow(
              color: shadow.withOpacity(0.45),
              offset: const Offset(20, 20),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class BgPainter extends CustomPainter {
  const BgPainter();

  @override
  void paint(Canvas canvas, Size s) {
    final blob = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 70);
    blob.color = hotPink.withOpacity(0.35);
    canvas.drawCircle(Offset(s.width * .08, s.height * .15), 200, blob);
    blob.color = aqua.withOpacity(0.25);
    canvas.drawCircle(Offset(s.width * .95, s.height * .8), 240, blob);
    blob.color = sun.withOpacity(0.2);
    canvas.drawCircle(Offset(s.width * .7, s.height * .02), 150, blob);

    final stripe = Paint()
      ..color = lime.withOpacity(0.07)
      ..strokeWidth = 10;
    for (double i = -s.height; i < s.width; i += 64) {
      canvas.drawLine(Offset(i, s.height), Offset(i + s.height, 0), stripe);
    }

    final dot = Paint()..color = Colors.white.withOpacity(0.14);
    for (double x = 12; x < s.width; x += 26) {
      for (double y = 12; y < s.height; y += 26) {
        canvas.drawCircle(Offset(x, y), 1.6, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class CreditFooter extends StatelessWidget {
  const CreditFooter({super.key});

  static const _grad = LinearGradient(colors: [sun, hotPink, aqua, lime]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: ink,
        borderRadius: BorderRadius.circular(360),
        border: Border.all(color: sun, width: 3),
        boxShadow: const [BoxShadow(color: hotPink, offset: Offset(6, 6))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (b) => _grad.createShader(b),
            child: const Icon(
              Icons.favorite_rounded,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          ShaderMask(
            shaderCallback: (b) => _grad.createShader(b),
            child: const Text(
              "Made by Muzamil Hussain",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
