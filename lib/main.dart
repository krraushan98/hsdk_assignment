import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hsdk_assignment/Screens/home.dart';
import 'package:hsdk_assignment/Screens/login.dart';
import 'package:hsdk_assignment/Services/auth_provider.dart';
import 'package:hsdk_assignment/Services/connectivity_provider.dart';
import 'package:hsdk_assignment/firebase_options.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InternetConnectivityProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<InternetConnectivityProvider>(
        builder: (context, connectivityProvider, child) {
          if (!connectivityProvider.isConnected) {
            Future.microtask(() {
              showDialog(
                context: context,
                barrierDismissible:
                    false,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Row(
                    children: [
                      Icon(Icons.wifi_off_rounded,
                          color: Colors.redAccent, size: 28),
                      SizedBox(width: 8),
                      Text("No Internet",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lottie/no_internet.json', 
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "You're offline! Please check your internet connection.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 100,vertical: 10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text("Retry", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              );
            });
          }
          return Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return authProvider.user != null
                  ? const HomePage()
                  : const LoginPage();
            },
          );
        },
      ),
    );
  }
}
