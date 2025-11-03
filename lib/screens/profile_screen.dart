import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/info_card.dart';
import 'about_me_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/user.json');
    setState(() {
      userData = json.decode(jsonString);
    });
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (_) {
        final nameController = TextEditingController();
        final messageController = TextEditingController();
        return AlertDialog(
          title: const Text('Contact Me'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
              ),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(labelText: 'Message'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Send'),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Message sent successfully!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.email_outlined),
            onPressed: _showContactDialog,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AboutMePage()),
          );
        },
        label: const Text('About Me'),
        icon: const Icon(Icons.info_outline),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Hero(
              tag: 'profile-image',
              child: CircleAvatar(
                radius: 70,
                backgroundImage: const AssetImage('assets/images/profile.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            userData!['name'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            userData!['profession'],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(
            userData!['bio'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 25),
          ...[
            InfoCard(
              icon: Icons.email,
              text: userData!['email'],
              onTap: () => _launchUrl('mailto:${userData!['email']}'),
            ),
            InfoCard(
              icon: Icons.phone,
              text: userData!['phone'],
              onTap: () => _launchUrl('tel:${userData!['phone']}'),
            ),
            InfoCard(
              icon: Icons.location_on,
              text: userData!['location'],
              onTap: () => _launchUrl(
                  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(userData!['location'])}'),
            ),
          ],
          const Divider(),
          const SizedBox(height: 10),
          Text('Social Profiles',
              style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.business_center),
                onPressed: () => _launchUrl(userData!['linkedin']),
              ),
              IconButton(
                icon: const Icon(Icons.code),
                onPressed: () => _launchUrl(userData!['github']),
              ),
              IconButton(
                icon: const Icon(Icons.alternate_email),
                onPressed: () => _launchUrl(userData!['twitter']),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
