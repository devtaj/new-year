import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;
  late AnimationController _slideUpController;
  late Animation<Offset> _slideUpAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation for the main text
    _fadeInController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeIn),
    );

    // Slide-up animation for the copyright text
    _slideUpController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _slideUpAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _slideUpController, curve: Curves.easeOut),
    );

    // Start the animations
    _fadeInController.forward();
    _slideUpController.forward();
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    _slideUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/new ye.webp'), // Ensure this image exists
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent overlay for text readability
          Container(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
          ),
          // Content on top of the image with fade-in effect
          FadeTransition(
            opacity: _fadeInAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Happy New Year 2025',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Wishing you joy, health, and success!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Copyright text with slide-up animation
          SlideTransition(
            position: _slideUpAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Copyright © 2025 devtajpuriya.com.np',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
