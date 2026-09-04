import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _imageAsset = 'assets/images/login_makeup.png';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.onForgotPassword,
    this.onSignIn,
    this.onCreateAccount,
    this.onGoogleSignIn,
    this.onAppleSignIn,
  });

  final VoidCallback? onForgotPassword;
  final VoidCallback? onSignIn;
  final VoidCallback? onCreateAccount;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAppleSignIn;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController(
    text: 'jane@example.com',
  );

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSignIn?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F0F1),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x18000000),
                  blurRadius: 16,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(29, 20, 29, 28),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildHeader(context),

                          const SizedBox(height: 22),

                          _buildMainImage(),

                          const SizedBox(height: 27),

                          const Text(
                            'Welcome Back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF202938),
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Sign in to continue your beauty journey',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF737B8C),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 24),

                          _buildLabel('EMAIL ADDRESS'),

                          const SizedBox(height: 7),

                          _buildEmailField(),

                          const SizedBox(height: 17),

                          _buildPasswordHeader(),

                          const SizedBox(height: 7),

                          _buildPasswordField(),

                          const SizedBox(height: 24),

                          _buildSignInButton(),

                          const SizedBox(height: 26),

                          _buildDivider(),

                          const SizedBox(height: 24),

                          _buildSocialButtons(),

                          const SizedBox(height: 22),

                          _buildCreateAccount(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
            child: Text(
              'GLOSS & GLAM',
              style: TextStyle(
                color: Color(0xFF202938),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
              ),
            ),
          ),

          Positioned(
            left: -8,
            child: GestureDetector(
              onTap: () => Navigator.maybePop(context),
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                width: 35,
                height: 35,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFFE82A83),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // IMAGE
  // ==========================================================

  Widget _buildMainImage() {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 274 / 230,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Image.asset(
            _imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF22272B),
                child: const Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // LABEL
  // ==========================================================

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFCF719A),
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // ==========================================================
  // EMAIL
  // ==========================================================

  Widget _buildEmailField() {
    return SizedBox(
      height: 47,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Color(0xFF697182), fontSize: 14),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Ingresa tu correo';
          }

          if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
            return 'Correo no válido';
          }

          return null;
        },
        decoration: _inputDecoration(
          icon: Icons.mail_outline_rounded,
          hint: 'jane@example.com',
        ),
      ),
    );
  }

  // ==========================================================
  // PASSWORD HEADER
  // ==========================================================

  Widget _buildPasswordHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLabel('PASSWORD'),

        GestureDetector(
          onTap: widget.onForgotPassword,
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              color: Color(0xFF5A7FA5),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PASSWORD FIELD
  // ==========================================================

  Widget _buildPasswordField() {
    return SizedBox(
      height: 47,
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        style: const TextStyle(color: Color(0xFF697182), fontSize: 14),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingresa tu contraseña';
          }

          return null;
        },
        decoration: _inputDecoration(
          icon: Icons.lock_outline_rounded,
          hint: '••••••••',
        ),
      ),
    );
  }

  // ==========================================================
  // INPUT DECORATION
  // ==========================================================

  InputDecoration _inputDecoration({
    required IconData icon,
    required String hint,
  }) {
    const borderColor = Color(0xFFE8DDE2);

    return InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(color: Color(0xFF7A8190), fontSize: 14),

      prefixIcon: Icon(icon, size: 18, color: const Color(0xFFE5A1BB)),

      filled: true,
      fillColor: const Color(0xFFFAF8F9),

      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE5A1BB), width: 1.2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE82A83)),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE82A83)),
      ),
    );
  }

  // ==========================================================
  // SIGN IN BUTTON
  // ==========================================================

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: _submit,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFE72984),
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4DE72984),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Sign In  →',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // DIVIDER
  // ==========================================================

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFF0E8EB), thickness: 1)),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR CONNECT WITH',
            style: TextStyle(
              color: Color(0xFF7C8492),
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),

        const Expanded(child: Divider(color: Color(0xFFF0E8EB), thickness: 1)),
      ],
    );
  }

  // ==========================================================
  // SOCIAL BUTTONS
  // ==========================================================

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            label: 'Google',
            icon: _googleIcon(),
            onTap: widget.onGoogleSignIn,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _socialButton(
            label: 'Apple',
            icon: const _AppleLogo(),
            onTap: widget.onAppleSignIn,
          ),
        ),
      ],
    );
  }

  Widget _socialButton({
    required String label,
    required Widget icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFEDE4E8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,

            const SizedBox(width: 8),

            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF303744),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // GOOGLE ICON
  // ==========================================================

  Widget _googleIcon() {
    return SvgPicture.asset(
      'assets/images/google_logo.svg',
      width: 22,
      height: 22,
    );
  }

  // ==========================================================
  // CREATE ACCOUNT
  // ==========================================================

  Widget _buildCreateAccount() {
    return GestureDetector(
      onTap: widget.onCreateAccount,
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'New to GLOSS & GLAM? ',
              style: TextStyle(
                color: Color(0xFF6E7685),
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
              ),
            ),

            TextSpan(
              text: 'Create Account',
              style: TextStyle(
                color: Color(0xFFE72984),
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _AppleLogo extends StatelessWidget {
  const _AppleLogo();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'iOS',
      style: TextStyle(
        color: Color(0xFF202938),
        fontSize: 14,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
      ),
    );
  }
}
