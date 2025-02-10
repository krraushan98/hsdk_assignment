import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsdk_assignment/Screens/login.dart';
import 'package:hsdk_assignment/Services/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                   child: user?.photoURL != null
                  ? Image.network(user!.photoURL!)
                  : Icon(Icons.person), // Replace with actual image
                ),
                const SizedBox(width: 12),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Take Care!",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    if (user != null)
                      Text(
                        user.displayName ?? 'No Name',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    else
                      const Text(
                        'User',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Settings Section
            const Text("Settings",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            _buildSettingsItem(Icons.notifications_none, "Notification",
                "Check your medicine notification"),
            _buildSettingsItem(
                Icons.volume_up, "Sound", "Ring, Silent, Vibrate"),
            _buildSettingsItem(Icons.person_outline, "Manage Your Account",
                "Password, Email ID, Phone Number"),
            _buildSettingsItem(Icons.notifications_none, "Notification",
                "Check your medicine notification"),
            _buildSettingsItem(Icons.notifications_none, "Notification",
                "Check your medicine notification"),

            const SizedBox(height: 24),

            // Device Section
            const Text("Device",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDeviceItem(Icons.wifi, "Connect", "Bluetooth, Wi-Fi"),
                  const SizedBox(height: 12),
                  _buildDeviceItem(
                      Icons.volume_up, "Sound Option", "Ring, Silent, Vibrate",
                      isWhite: true),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Caretakers Section
            const Text("Caretakers: 03",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCaretakerAvatar(null), // Replace with actual image
                  _buildCaretakerAvatar(null),
                  _buildCaretakerAvatar(null),
                  _buildCaretakerAvatar(null, isAdd: true),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Doctor Section
            const Text("Doctor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text("Add Your Doctor",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: "Or use ",
                      children: [
                        TextSpan(
                            text: "invite link",
                            style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Privacy & Log Out
            _buildSimpleItem("Privacy Policy"),
            _buildSimpleItem("Terms of Use"),
            _buildSimpleItem("Rate Us"),
            _buildSimpleItem("Share"),

            const SizedBox(height: 24),

            // Log Out Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await authProvider.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Log Out",
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade600),
      title: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildDeviceItem(IconData icon, String title, String subtitle,
      {bool isWhite = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWhite ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaretakerAvatar(String? imagePath, {bool isAdd = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: isAdd ? Colors.grey.shade300 : Colors.white,
        backgroundImage: imagePath != null ? AssetImage(imagePath) : null,
        child: isAdd ? const Icon(Icons.add, color: Colors.black) : null,
      ),
    );
  }

  Widget _buildSimpleItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}
