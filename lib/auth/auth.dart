// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/lecturer/teacher_attendance.dart';
import 'package:attendance_app/student/student_attendance.dart';

const double kHorizontalPadding = 32.0;
const double kVerticalPadding = 24.0;

Color primary = Colors.blue[800]!;

const landingImageUrl =
    'https://flutter-ui.s3.us-east-2.amazonaws.com/login_register_illustration/undraw_happy_announcement_ac67.png';
const loginImageUrl =
    'https://flutter-ui.s3.us-east-2.amazonaws.com/login_register_illustration/undraw_welcome_3gvl.png';
const registerImageUrl =
    'https://flutter-ui.s3.us-east-2.amazonaws.com/login_register_illustration/undraw_Fingerprint_re_uf3f.png';

class Intro extends StatelessWidget {
  const Intro({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 400, maxHeight: 400),
                child: Image.network(landingImageUrl),
              ),
              const SizedBox(height: 32),
              const Center(
                child: Text(
                  'Attendance Logger',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Attendance Logging Made Simple',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SimpleElevatedButton(
                        color: primary,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterWithIllustration(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: SimpleOutlinedButton(
                        color: primary,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginWithIllustration(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 48)
            ],
          ),
        ),
      ),
    );
  }
}

class LoginWithIllustration extends StatefulWidget {
  const LoginWithIllustration({Key? key});

  @override
  State<LoginWithIllustration> createState() => _LoginWithIllustrationState();
}

class _LoginWithIllustrationState extends State<LoginWithIllustration> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn(BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? user = userCredential.user;
      if (user != null) {
        // Check the user's email to determine their role
        if (user.email != null && user.email!.contains("@teacher.com")) {
          // Teacher authenticated, navigate to teacher dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TeacherAttendance()),
          );
        } else {
          // Student authenticated, navigate to student dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StudentAttendance()),
          );
        }
      }
    } catch (e) {
      // Handle sign-in errors
      print('Error signing in: $e');
      // Show error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          children: [
            const SizedBox(height: 32),
            SimpleIconButton(
              iconData: Icons.arrow_back,
              fillColor: primary.withOpacity(.15),
              iconColor: primary,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
              child: Image.network(
                loginImageUrl,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              style: const TextStyle(fontSize: 18),
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: primary.withOpacity(.15),
                filled: true,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: primary.withOpacity(.15),
                filled: true,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 52,
              child: SimpleElevatedButton(
                color: primary,
                onPressed: () => _signIn(context),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterWithIllustration extends StatefulWidget {
  const RegisterWithIllustration({Key? key});

  @override
  State<RegisterWithIllustration> createState() =>
      _RegisterWithIllustrationState();
}

class _RegisterWithIllustrationState extends State<RegisterWithIllustration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          children: [
            const SizedBox(height: 32),
            SimpleIconButton(
              iconData: Icons.arrow_back,
              fillColor: primary.withOpacity(.15),
              iconColor: primary,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
              child: Image.network(
                registerImageUrl,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(fontSize: 18),
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: primary.withOpacity(.15),
                filled: true,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: primary.withOpacity(.15),
                filled: true,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Confirm Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: primary.withOpacity(.15),
                filled: true,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 52,
              child: SimpleElevatedButton(
                color: primary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentAttendance()),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleElevatedButton extends StatelessWidget {
  const SimpleElevatedButton({required this.child, required this.color, required this.onPressed, Key? key});
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class SimpleOutlinedButton extends StatelessWidget {
  const SimpleOutlinedButton(
      {required this.child,
      required this.color,
      required this.onPressed,
      Key? key});
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class SimpleIconButton extends StatelessWidget {
  const SimpleIconButton(
      {this.fillColor = Colors.transparent,
      required this.iconData,
      this.iconColor = Colors.blue,
      this.outlineColor = Colors.transparent,
      this.notificationFillColor = Colors.red,
      this.notificationCount,
      required this.onPressed,
      this.radius = 48.0,
      Key? key});

  final IconData iconData;
  final Color fillColor;
  final Color outlineColor;
  final Color iconColor;
  final Color notificationFillColor;
  final int? notificationCount;
  final VoidCallback onPressed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Ink(
          width: radius,
          height: radius,
          decoration: ShapeDecoration(
            color: fillColor,
            shape: CircleBorder(side: BorderSide(color: outlineColor)),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: radius / 2,
            iconSize: radius / 2,
            icon: Icon(iconData, color: iconColor),
            splashColor: iconColor.withOpacity(.4),
            onPressed: onPressed,
          ),
        ),
        if (notificationCount != null) ...[
          Positioned(
            top: radius / -14,
            right: radius / -14,
            child: Container(
              width: radius / 2.2,
              height: radius / 2.2,
              decoration: ShapeDecoration(
                color: notificationFillColor,
                shape: const CircleBorder(),
              ),
              child: Center(
                child: Text(
                  notificationCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: radius / 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Intro(),
  ));
}
