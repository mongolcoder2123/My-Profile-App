import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  final List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'level': 0.9},
    {'name': 'Dart', 'level': 0.85},
    {'name': 'Python', 'level': 0.8},
    {'name': 'Machine Learning', 'level': 0.75},
    {'name': 'Firebase', 'level': 0.7},
  ];

  final List<String> hobbies = [
    'Coding innovative apps',
    'Exploring new tech trends',
    'Playing video games',
    'Photography and art',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Me')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Education',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const ListTile(
            leading: Icon(Icons.school),
            title: Text('BS in Computer Science - Karakoram International University'),
            subtitle: Text('2020 - 2024'),
          ),
          const ListTile(
            leading: Icon(Icons.workspace_premium),
            title: Text('Certified Flutter Developer'),
            subtitle: Text('Google / Udemy'),
          ),
          const Divider(),
          const Text(
            'Skills',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...skills.map((skill) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(skill['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                  LinearProgressIndicator(
                    value: skill['level'],
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 10),
                ],
              )),
          const Divider(),
          const Text(
            'Hobbies',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8,
            children: hobbies.map((hobby) => Chip(label: Text(hobby))).toList(),
          ),
        ],
      ),
    );
  }
}
