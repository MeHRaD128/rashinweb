import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// نگهدارنده وضعیت تم به صورت گلوبال
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

class AuthXAppTwo extends StatelessWidget {
  const AuthXAppTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Flutter AuthX',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          home: const AuthXScreen(),
        );
      },
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      fontFamily: 'Roboto',
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFF2D87),
        surface: Color(0xFF1A1A1A),
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      fontFamily: 'Roboto',
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFFF2D87),
        surface: Colors.white,
      ),
    );
  }
}

class AuthXScreen extends StatefulWidget {
  const AuthXScreen({super.key});

  @override
  State<AuthXScreen> createState() => _AuthXScreenState();
}

class _AuthXScreenState extends State<AuthXScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isLogin = true;
  bool _obscurePassword = true;
  bool _showError = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // رنگ‌های اصلی برند (ثابت در هر دو تم)
  static const Color _pinkAccent = Color(0xFFFF2D87);
  static const Color _orangeAccent = Color(0xFFFFA84B);

  static const LinearGradient _buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [_pinkAccent, _orangeAccent],
  );

  // بررسی اینکه آیا در حالت تیره هستیم یا نه
  bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // رنگ‌های داینامیک بر اساس تم
  Color _bgColor(BuildContext c) =>
      _isDarkMode(c) ? const Color(0xFF0A0A0A) : const Color(0xFFF5F5F7);
  Color _cardColor(BuildContext c) =>
      _isDarkMode(c) ? const Color(0xFF1A1A1A) : Colors.white;
  Color _fieldColor(BuildContext c) =>
      _isDarkMode(c) ? const Color(0xFF141414) : const Color(0xFFF0F0F3);
  Color _borderColor(BuildContext c) =>
      _isDarkMode(c) ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0);
  Color _textColor(BuildContext c) =>
      _isDarkMode(c) ? Colors.white : const Color(0xFF1A1A1A);
  Color _subTextColor(BuildContext c) =>
      _isDarkMode(c) ? Colors.grey[500]! : Colors.grey[600]!;
  Color _hintColor(BuildContext c) =>
      _isDarkMode(c) ? Colors.grey[600]! : Colors.grey[500]!;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
      _showError = false;
    });
    _animationController.reset();
    _animationController.forward();
  }

  void _submit() {
    setState(() => _showError = false);
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isLogin ? 'Login Successful ✅' : 'Account Created ✅'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      if (_isLogin) setState(() => _showError = true);
    }
  }

  // چرخش بین سه حالت تم
  void _cycleTheme() {
    final current = themeNotifier.value;
    ThemeMode next;
    String label;
    if (current == ThemeMode.dark) {
      next = ThemeMode.light;
      label = 'Light Mode ☀️';
    } else if (current == ThemeMode.light) {
      next = ThemeMode.system;
      label = 'System Mode ⚙️';
    } else {
      next = ThemeMode.dark;
      label = 'Dark Mode 🌙';
    }
    themeNotifier.value = next;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(label),
        duration: const Duration(seconds: 1),
        backgroundColor: _pinkAccent,
      ),
    );
  }

  // آیکون بر اساس تم فعلی
  IconData _themeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.system:
        return Icons.settings_suggest_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor(context),
      body: Stack(
        children: [
          // خط گرادیانت تزئینی
          Positioned(
            top: 100,
            right: -50,
            child: Container(
              width: 300,
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, _pinkAccent, Colors.transparent],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            "assets/images/logo-s.png",
                            width: 150,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Image.asset(
                            "assets/images/rashinweb-text.png",
                            width: 250,
                          ),
                        ),
                        // ==================================================
                        // Description
                        // ==================================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "رشد کسب و کار",
                              style: TextStyle(
                                fontFamily: "On",
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20,
                              ),
                            ),

                            _divider(),

                            Text(
                              "سئو",
                              style: TextStyle(
                                fontFamily: "On",
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20,
                              ),
                            ),

                            _divider(),

                            Text(
                              "طراحی سایت",
                              style: TextStyle(
                                fontFamily: "On",
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSubtitle(),
                        const SizedBox(height: 20),
                        _buildSocialButtons(),
                        const SizedBox(height: 20),
                        if (!_isLogin) ...[
                          _buildLabel('Name'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Hammad Anwar',
                            validator: (v) => v == null || v.isEmpty
                                ? 'Enter your name'
                                : null,
                          ),
                          const SizedBox(height: 18),
                        ],
                        _buildLabel('Email'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          hint: 'rh676838@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          suffixIcon:
                              _emailController.text.isNotEmpty &&
                                  RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(_emailController.text)
                              ? const Icon(
                                  Icons.check,
                                  color: _pinkAccent,
                                  size: 20,
                                )
                              : null,
                          onChanged: (_) => setState(() {}),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        _buildLabel('Password'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _passwordController,
                          hint: _isLogin
                              ? '••••••••'
                              : 'Pick a strong password',
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: _subTextColor(context),
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        _buildMainButton(),
                        const SizedBox(height: 20),
                        if (_showError && _isLogin) _buildErrorBox(),
                        if (_showError && _isLogin) const SizedBox(height: 20),
                        _buildToggleText(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // هدر شامل دکمه بازگشت + عنوان + دکمه تغییر تم
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _cardColor(context),
            shape: BoxShape.circle,
            border: Border.all(color: _borderColor(context)),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: _textColor(context),
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(width: 12),
        Text(
          _isLogin ? 'Sign in' : 'Sign up',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: _textColor(context),
          ),
        ),
        const Spacer(),
        // دکمه تغییر تم
        _buildThemeToggleButton(),
      ],
    );
  }

  Widget _buildThemeToggleButton() {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return GestureDetector(
          onTap: _cycleTheme,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: _buttonGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _pinkAccent.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(
                    begin: 0.75,
                    end: 1.0,
                  ).animate(animation),
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: Icon(
                _themeIcon(mode),
                key: ValueKey(mode),
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtitle() {
    return Text(
      _isLogin
          ? 'Sign in with one of the following options'
          : 'Sign up with one of the following options',
      style: TextStyle(fontSize: 13, color: _subTextColor(context)),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(child: _socialButton(child: _googleIcon())),
        const SizedBox(width: 15),
        Expanded(
          child: _socialButton(
            child: Icon(Icons.apple, color: _textColor(context), size: 28),
          ),
        ),
      ],
    );
  }

  Widget _socialButton({required Widget child}) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: _cardColor(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _borderColor(context)),
        ),
        child: Center(child: child),
      ),
    );
  }

  Widget _googleIcon() {
    return Text(
      'G',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _textColor(context),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, color: _subTextColor(context)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _fieldColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor(context)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(color: _textColor(context), fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: _hintColor(context), fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          errorStyle: const TextStyle(color: _pinkAccent, fontSize: 11),
        ),
      ),
    );
  }

  Widget _buildMainButton() {
    return GestureDetector(
      onTap: _submit,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: _buttonGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: _pinkAccent.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _isLogin ? 'Login Account' : 'Create Account',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.redAccent,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Error',
                  style: TextStyle(
                    color: _textColor(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
                  style: TextStyle(
                    color: _subTextColor(context),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleText() {
    return Center(
      child: GestureDetector(
        onTap: _toggleMode,
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 13, color: _subTextColor(context)),
            children: [
              TextSpan(
                text: _isLogin
                    ? "Don't have an account? "
                    : 'Already have an account? ',
              ),
              const TextSpan(text: ''),
              TextSpan(
                text: _isLogin ? 'Sign up' : 'Login',
                style: const TextStyle(
                  color: _pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// Divider
// ============================================================

Widget _divider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),

    child: Container(
      width: 1,
      height: 16,

      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B),

        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
