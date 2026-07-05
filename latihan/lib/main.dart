import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'core/constants/colors.dart';
import 'core/services/firebase/firebase_auth_service.dart';
import 'features/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aksara Bima',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
        ),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: AppColors.textPrimary,
              displayColor: AppColors.textPrimary,
            ),
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            ),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return DashboardScreen(user: snapshot.data!);
        }
        return const LoginScreen();
      },
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final User user;
  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Aksara Bima'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.primary),
            onPressed: () async {
              await FirebaseAuthService().signOut();
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            );
          }

          String displayName = user.email ?? 'Teman';
          String fullName = '-';
          String school = '-';
          String address = '-';

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data();
            if (data != null) {
              displayName = data['display_name'] ?? displayName;
              fullName = data['full_name'] ?? '-';
              school = data['school'] ?? '-';
              address = data['address'] ?? '-';
            }
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome message banner (cheerful pastel yellow background)
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppColors.pastelGold,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.secondary.withAlpha(80), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textPrimary.withAlpha(10),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.stars_rounded, color: AppColors.secondary, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Status Akses:',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textPrimary.withAlpha(180),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'berhasil login, $displayName! 👋',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Selamat belajar Aksara Bima digital platform. Mari bersenang-senang mempelajari aksara tradisional kita!',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  
                  // User Profile details card (white background, colorful items)
                  Text(
                    'Informasi Profil Kamu',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textPrimary.withAlpha(15),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildProfileRow(
                            Icons.person_rounded, 
                            'Nama Lengkap', 
                            fullName,
                            AppColors.merahBima,
                            AppColors.pastelRed,
                          ),
                          const Divider(color: Colors.black12, height: 20),
                          _buildProfileRow(
                            Icons.face_rounded, 
                            'Nama Panggilan', 
                            displayName,
                            AppColors.emasBima,
                            AppColors.pastelGold,
                          ),
                          const Divider(color: Colors.black12, height: 20),
                          _buildProfileRow(
                            Icons.school_rounded, 
                            'Asal Sekolah', 
                            school,
                            AppColors.hijauBima,
                            AppColors.pastelGreen,
                          ),
                          const Divider(color: Colors.black12, height: 20),
                          _buildProfileRow(
                            Icons.home_rounded, 
                            'Alamat', 
                            address,
                            AppColors.biruBima,
                            AppColors.pastelBlue,
                          ),
                          const Divider(color: Colors.black12, height: 20),
                          _buildProfileRow(
                            Icons.email_rounded, 
                            'Email Akun', 
                            user.email ?? '-',
                            AppColors.textSecondary,
                            AppColors.background,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Quick Action Button (large, child-friendly rounded button)
                  ElevatedButton.icon(
                    onPressed: () async {
                      await FirebaseAuthService().signOut();
                    },
                    icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
                    label: const Text(
                      'KELUAR DARI AKUN',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: AppColors.primary.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileRow(
    IconData icon, 
    String title, 
    String value,
    Color iconColor,
    Color iconBgColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Circular child-friendly icon background
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}