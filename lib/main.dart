import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  onSurface: const Color.fromARGB(255, 249, 248, 252),
);

final theme = ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.surface,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold),
  ),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: theme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
