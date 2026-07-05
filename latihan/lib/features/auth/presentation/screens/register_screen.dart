import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../core/services/firebase/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _addressController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _displayNameController.dispose();
    _schoolController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Sign up with Firebase Auth
      final credential = await _authService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final user = credential.user;
      if (user != null) {
        // 2. Save profile in Firestore
        await _firestoreService.createUserProfile(
          uid: user.uid,
          email: _emailController.text.trim(),
          fullName: _fullNameController.text.trim(),
          displayName: _displayNameController.text.trim(),
          school: _schoolController.text.trim(),
          address: _addressController.text.trim(),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pendaftaran berhasil!'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context); // Go back to login screen
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.primary, // Merah Bima
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Playful header icon
                  Center(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.pastelGold,
                          border: Border.all(color: AppColors.secondary, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textPrimary.withAlpha(15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.app_registration_rounded,
                          size: 48,
                          color: AppColors.primary, // Merah Bima
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Buat Akun Baru',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Daftar sekarang untuk mulai mengoleksi bintang belajarmu!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),

                  // Full Name Field (Red Accent)
                  _buildTextField(
                    controller: _fullNameController,
                    label: 'Nama Lengkap Kamu',
                    icon: Icons.person_rounded,
                    iconColor: AppColors.merahBima,
                    focusedBorderColor: AppColors.merahBima,
                    validator: (v) => v == null || v.isEmpty ? 'Nama lengkap tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),

                  // Nickname Field (Yellow/Gold Accent)
                  _buildTextField(
                    controller: _displayNameController,
                    label: 'Nama Panggilan Kamu',
                    icon: Icons.face_rounded,
                    iconColor: AppColors.emasBima,
                    focusedBorderColor: AppColors.emasBima,
                    validator: (v) => v == null || v.isEmpty ? 'Nama panggilan tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),

                  // School Field (Green Accent)
                  _buildTextField(
                    controller: _schoolController,
                    label: 'Asal Sekolah',
                    icon: Icons.school_rounded,
                    iconColor: AppColors.hijauBima,
                    focusedBorderColor: AppColors.hijauBima,
                    validator: (v) => v == null || v.isEmpty ? 'Asal sekolah tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),

                  // Address Field (Blue Accent)
                  _buildTextField(
                    controller: _addressController,
                    label: 'Alamat Rumah',
                    icon: Icons.home_rounded,
                    iconColor: AppColors.biruBima,
                    focusedBorderColor: AppColors.biruBima,
                    validator: (v) => v == null || v.isEmpty ? 'Alamat tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_rounded,
                    iconColor: AppColors.textPrimary,
                    focusedBorderColor: AppColors.textPrimary,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email tidak boleh kosong';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) return 'Format email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password Baru',
                    icon: Icons.lock_rounded,
                    iconColor: AppColors.textSecondary,
                    focusedBorderColor: AppColors.primary,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password tidak boleh kosong';
                      if (v.length < 6) return 'Password minimal terdiri dari 6 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 36),

                  // Register Button (large, child-friendly rounded button)
                  ElevatedButton(
                    onPressed: _isLoading ? null : _register,
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
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'DAFTAR SEKARANG',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Switch to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun? ',
                        style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color iconColor,
    required Color focusedBorderColor,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: iconColor),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black12, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: validator,
    );
  }
}
