import 'dart:ui';
import 'package:flutter/material.dart';
import 'widgets/auth_textfield.dart';
import 'widgets/auth_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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

                    // Logo Section
                    _buildLogo(),

                    const SizedBox(height: 40),

                    /// Phone Number
                    AuthTextField(
                      controller: _phoneController,
                      label: "Số điện thoại",
                      hint: "Nhập số điện thoại",
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

                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Quên mật khẩu?",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Login Button
                    _buildLoginButton(),

                    const SizedBox(height: 20),

                    /// Register Button (Outlined style)
                    _buildRegisterButton(),

                    const SizedBox(height: 40),

                    // Social Login Divider
                    _buildSocialDivider(),

                    const SizedBox(height: 25),

                    // Social Icons
                    _buildSocialIcons(),

                    const SizedBox(height: 50),

                    // Footer
                    Text(
                      "\u00a9 2026 Let's Play Inc\\.",
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
        // Top Left Pattern
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
        // Top Right Pattern
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
        // Bottom Right Pattern
        Positioned(
          bottom: 150,
          right: -80,
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
                Icons.sports_esports_outlined,
                size: 60,
                color: Color(0xFFFE4C71), // Logo color from mockup
              ),
            ),
            // Floating flower icon on logo
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
          "Let's Play",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Vui Tết sum vầy",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
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
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          borderRadius: BorderRadius.circular(30),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ĐĂNG NHẬP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.login, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Material(
        color: Colors.white.withOpacity(0.05),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()),
            );
          },
          borderRadius: BorderRadius.circular(30),
          child: const Center(
            child: Text(
              "ĐĂNG KÝ",
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

  Widget _buildSocialDivider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: Colors.white.withOpacity(0.1)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF580345),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "HOẶC ĐĂNG NHẬP BẰNG",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon('static_assets/images/google_icon.png', Colors.red),
        const SizedBox(width: 25),
        _socialIcon('static_assets/images/facebook_icon.png', Colors.blue),
        const SizedBox(width: 25),
        _socialIcon('static_assets/images/tiktok_icon.png', Colors.black),
      ],
    );
  }

  Widget _socialIcon(String asset, Color color) {
    // Note: Using Icons for now as placeholders if assets don't exist
    IconData icon;
    if (asset.contains('google'))
      icon = Icons.g_mobiledata;
    else if (asset.contains('facebook'))
      icon = Icons.facebook;
    else
      icon = Icons.music_note;

    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
