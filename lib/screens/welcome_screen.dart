import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  const WelcomeScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'profile-image',
                child: CircleAvatar(
                  backgroundImage: const AssetImage('assets/images/profile.jpg'),
                  radius: 70,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome to My Profile',
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen()),
                ),
                icon: const Icon(Icons.person),
                label: const Text('View Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: toggleTheme,
                icon: const Icon(Icons.brightness_6, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
