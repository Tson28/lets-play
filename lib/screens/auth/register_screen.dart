import 'dart:ui';
import 'package:flutter/material.dart';
import 'widgets/auth_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF580345), // Deep Purple/Wine
                  Color(0xFFB01D5E), // Magenta
                  Color(0xFFFE4C71), // Coral Pink
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 2. Geometric Decor Patterns
          _buildGeometricPatterns(),

          // 3. Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    
                    // Logo Section (Same as Login)
                    _buildLogo(),

                    const SizedBox(height: 40),

                    /// Full Name
                    AuthTextField(
                      controller: _nameController,
                      label: "Họ và tên",
                      hint: "Nhập họ và tên",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập họ và tên";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    /// Phone Number
                    AuthTextField(
                      controller: _phoneController,
                      label: "Số điện thoại",
                      hint: "09xx xxx xxx",
                      icon: Icons.phone_android_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập số điện thoại";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    /// Password
                    AuthTextField(
                      controller: _passwordController,
                      label: "Mật khẩu",
                      hint: "Nhập mật khẩu",
                      icon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white38,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Mật khẩu phải ít nhất 6 ký tự";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40),

                    /// Register Button
                    _buildRegisterButton(),

                    const SizedBox(height: 20),

                    // Back to Login
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Đã có tài khoản? Đăng nhập ngay",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Footer
                    Text(
                      "\u00a9 2026 Let's Play Inc.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeometricPatterns() {
    return Stack(
      children: [
        Positioned(
          top: -30,
          left: -80,
          child: Opacity(
            opacity: 0.9,
            child: Image.asset(
              'static_assets/images/tet_pattern.png',
              width: 250,
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: -100,
          child: Opacity(
            opacity: 0.9,
            child: Image.asset(
              'static_assets/images/tet_pattern.png',
              width: 220,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -100,
          child: Opacity(
            opacity: 0.9,
            child: Image.asset(
              'static_assets/images/tet_pattern.png',
              width: 250,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: const Icon(
                Icons.person_add_outlined,
                size: 60,
                color: Color(0xFFFE4C71),
              ),
            ),
            const Positioned(
              top: -5,
              right: -5,
              child: Icon(
                Icons.local_florist,
                color: Color(0xFFFFD700),
                size: 24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Tạo tài khoản mới",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Bắt đầu hành trình cùng Let's Play",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFFFE6B8B), Color(0xFFFF8E53)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFE6B8B).withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              // Handle registration
            }
          },
          borderRadius: BorderRadius.circular(30),
          child: const Center(
            child: Text(
              "ĐĂNG KÝ NGAY",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
