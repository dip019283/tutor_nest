

import 'package:flutter/material.dart';
import 'dart:math'; // Import this for pi

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Grid
          Container(
            color: Colors.white,
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              // painter: GridPainter(),
            ),
          ),
          // Logo and Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex:2),
              // Logo
              Column(
                children: [
                  Image.asset(
                    'assets/education_logo.png', // Replace with your logo
                    height: 100,
                  ),
                ],
              ),
              Spacer(flex:2),
              // Animated Icons Row
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     // Tilted school icon on the left
              //     Transform(
              //       transform: Matrix4.rotationZ(30 * pi / 180), // Rotate by 15 degrees
              //       alignment: Alignment.center, // Center rotation
              //       child: Icon(
              //         Icons.school,
              //         size: 40,
              //         color: Colors.black,
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     // Circles with dropping animation
              //     AnimatedDroppingCircle(size: 30, color: Colors.black),
              //     const SizedBox(width: 15),
              //     AnimatedDroppingCircle(size: 18, color: Colors.black45),
              //     const SizedBox(width: 15),
              //     AnimatedDroppingCircle(size: 6, color: Colors.blue),
              //   ],
              // ),

              // Animated Icons Row
              Padding(
                padding: const EdgeInsets.only(left: 135.0), // Adjust this value for how far left you want it
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Aligns items to the left
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Tilted school icon on the left
                    Transform(
                      transform: Matrix4.rotationZ(30 * pi / 180), // Rotate by 15 degrees
                      alignment: Alignment.center, // Center rotation
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 20), // Spacing after the school icon
                    // Circles with dropping animation
                    AnimatedDroppingCircle(size: 30, color: Colors.black),
                    const SizedBox(width: 15), // Spacing between circles
                    AnimatedDroppingCircle(size: 18, color: Colors.black45),
                    const SizedBox(width: 15), // Spacing between circles
                    AnimatedDroppingCircle(size: 6, color: Colors.blue),
                  ],
                ),
              ),



              Spacer(flex:3),
              // Tagline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "A vibrant community where tutors and students unite to share knowledge and achieve success together.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              // Get Started Button
              ElevatedButton(
                onPressed: () {
                  // Add your navigation logic here
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          // Green Curve
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 150,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Animated Dropping Circle
class AnimatedDroppingCircle extends StatelessWidget {
  final double size;
  final Color color;

  AnimatedDroppingCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -20, end: 0),
      duration: Duration(seconds: 2),
      curve: Curves.bounceOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Icon(Icons.circle, size: size, color: color),
        );
      },
    );
  }
}

// Custom Painter for Grid Lines
// class GridPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.red.withOpacity(0.3)
//       ..strokeWidth = 1;
//
//     for (double i = 0; i < size.width; i += 20) {
//       canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
//     }
//     for (double i = 0; i < size.height; i += 20) {
//       canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// Custom Clipper for Green Wave
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}


