import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rashinweb/test/login_screen_test_two.dart';

void main() => runApp(const AuthXApp());

class AuthXApp extends StatelessWidget {
  const AuthXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AuthX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthXScreen(),
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
  // کنترل‌کننده‌ی انیمیشن برای جابه‌جایی صفحه
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // وضعیت لاگین/ثبت‌نام (true = login, false = register)
  bool _isLogin = true;

  // کنترل‌کننده‌های فیلدها
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // کلیدهای فرم
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // تغییر حالت با انیمیشن
  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
    // ریست انیمیشن برای نمایش دوباره
    _animationController.reset();
    _animationController.forward();
  }

  // ارسال فرم
  void _submit() {
    if (_formKey.currentState!.validate()) {
      // در اینجا می‌توانید لاگین یا ثبت‌نام را هندل کنید
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isLogin ? 'ورود موفق ✅' : 'ثبت‌نام موفق ✅',
            style: TextStyle(fontFamily: "On"),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const AuthXAppTwo()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Colors.white.withOpacity(0.95),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // هدر
                            // const Text(
                            //   'FLUTTER AUTHX',
                            //   style: TextStyle(
                            //     fontSize: 28,
                            //     fontWeight: FontWeight.bold,
                            //     letterSpacing: 1.2,
                            //     color: Color(0xFF0F0C29),
                            //   ),
                            // ),
                            Image.asset("assets/images/logo-s.png", width: 150),
                            Image.asset("assets/images/rashinweb-text.png"),
                            // ==================================================
                            // Description
                            // ==================================================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "رشد کسب و کار",
                                  style: TextStyle(
                                    fontFamily: "On",
                                    color: CupertinoColors.inactiveGray,
                                    fontSize: 20,
                                  ),
                                ),

                                _divider(),

                                const Text(
                                  "سئو",
                                  style: TextStyle(
                                    fontFamily: "On",
                                    color: CupertinoColors.inactiveGray,
                                    fontSize: 20,
                                  ),
                                ),

                                _divider(),

                                const Text(
                                  "طراحی سایت",
                                  style: TextStyle(
                                    fontFamily: "On",
                                    color: CupertinoColors.inactiveGray,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isLogin
                                  ? 'به حساب خود وارد شوید'
                                  : 'حساب جدید بسازید',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: "On",
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // فیلد ایمیل
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontFamily: "On"),
                              decoration: InputDecoration(
                                labelText: 'ایمیل',
                                labelStyle: TextStyle(
                                  fontFamily: "On",
                                  fontSize: 20,
                                ),
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                errorStyle: TextStyle(
                                  fontFamily: "On",
                                  fontSize: 15,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'لطفاً ایمیل را وارد کنید';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'ایمیل معتبر نیست';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),

                            // فیلد رمز عبور
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: TextStyle(fontFamily: "On"),
                              decoration: InputDecoration(
                                labelText: 'رمز عبور',
                                labelStyle: TextStyle(
                                  fontFamily: "On",
                                  fontSize: 20,
                                ),
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                errorStyle: TextStyle(
                                  fontFamily: "On",
                                  fontSize: 15,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return 'رمز عبور حداقل ۶ کاراکتر';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),

                            // فیلد تکرار رمز (فقط در حالت ثبت‌نام)
                            if (!_isLogin)
                              Column(
                                children: [
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    style: TextStyle(
                                      fontFamily: "On",
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'تکرار رمز عبور',
                                      labelStyle: TextStyle(
                                        fontFamily: "On",
                                        fontSize: 20,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      errorStyle: TextStyle(
                                        fontFamily: "On",
                                        fontSize: 15,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value != _passwordController.text) {
                                        return 'رمزها مطابقت ندارند';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),

                            // دکمه فراموشی رمز (فقط لاگین)
                            if (_isLogin)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'لینک بازیابی ارسال شد',
                                          style: TextStyle(fontFamily: "On"),
                                        ),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'فراموشی رمز؟',
                                    style: TextStyle(
                                      fontFamily: "On",
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),

                            const SizedBox(height: 12),

                            // دکمه اصلی (ورود / ثبت‌نام)
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF302B63),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 8,
                                ),
                                child: Text(
                                  _isLogin ? 'ورود' : 'ثبت‌نام',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: "On",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // دکمه تغییر حالت
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: _toggleMode,
                                  child: Text(
                                    _isLogin ? 'ثبت‌نام' : 'ورود',
                                    style: const TextStyle(
                                      fontFamily: "On",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF302B63),
                                    ),
                                  ),
                                ),
                                Text(
                                  _isLogin
                                      ? 'حساب ندارید؟'
                                      : 'قبلاً ثبت‌نام کرده‌اید؟',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "On",
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                            const Divider(height: 30, thickness: 1),

                            // لینک لینکدین (مطابق عکس)
                            InkWell(
                              onTap: () {
                                // باز کردن لینک در مرورگر
                                // می‌توانید از url_launcher استفاده کنید
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'باز کردن لینکدین (لینک نمونه)',
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                '© 2026 Rashin Web. All rights reserved.',
                                style: TextStyle(
                                  color: Colors.indigoAccent,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
