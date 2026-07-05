import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  
  // Hitam (Dana Me'e): Melambangkan tanah, kesuburan, dan keteduhan.
  // Diubah menjadi versi Terang/Teduh yang lembut untuk anak-anak (soft cream).
  static const Color danaMee = Color(0xFFFAF7F2); // Soft Warm Sand
  static const Color background = Color(0xFFF5F2EB); // Cheerful light cream background
  static const Color surface = Color(0xFFFFFFFF);  // Pure White for Cards

  // Merah Bima: Melambangkan keberanian dan semangat juang (cheerful playful red).
  static const Color merahBima = Color(0xFFFF5252); 

  // Kuning / Emas Bima: Melambangkan keagungan, kemakmuran, dan kejayaan (sunny yellow).
  static const Color emasBima = Color(0xFFFFB300);  

  // Hijau Bima: Melambangkan kesuburan alam dan kesejahteraan (fresh lime green).
  static const Color hijauBima = Color(0xFF2ECC71); 

  // Biru Bima: Melambangkan kedamaian dan keteguhan hati (sky blue).
  static const Color biruBima = Color(0xFF3498DB);  

  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50); // Dark Blue-Gray for high contrast
  static const Color textSecondary = Color(0xFF7F8C8D); // Soft Slate Gray

  // UI Theme Mapping
  static const Color primary = merahBima;
  static const Color secondary = emasBima;
  static const Color success = hijauBima;
  static const Color info = biruBima;

  // Pastels for kids card styling
  static const Color pastelRed = Color(0xFFFFECEC);
  static const Color pastelGold = Color(0xFFFFF7E1);
  static const Color pastelGreen = Color(0xFFE8F8F0);
  static const Color pastelBlue = Color(0xFFEBF5FB);
}
