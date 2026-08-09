import 'package:flutter/cupertino.dart';
import 'package:rashinweb/test/login_screen_test.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ============================================================
  // Controllers
  // ============================================================

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ============================================================
  // Focus Nodes
  // ============================================================

  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  // ============================================================
  // State
  // ============================================================

  // 0 = ثبت نام
  // 1 = ورود
  int selected = 1;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // ============================================================
  // Dispose
  // ============================================================

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();

    super.dispose();
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF06101F),

      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),

            child: Column(
              children: [
                const SizedBox(height: 30),

                // ==================================================
                // Logo
                // ==================================================
                Image.asset("assets/images/logo-s.png", width: 150),

                const SizedBox(height: 5),

                // ==================================================
                // RASHIN WEB
                // ==================================================
                Image.asset("assets/images/rashinweb-text.png", width: 290),

                const SizedBox(height: 5),

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
                        color: CupertinoColors.white,
                        fontSize: 20,
                      ),
                    ),

                    _divider(),

                    const Text(
                      "سئو",
                      style: TextStyle(
                        fontFamily: "On",
                        color: CupertinoColors.white,
                        fontSize: 20,
                      ),
                    ),

                    _divider(),

                    const Text(
                      "طراحی سایت",
                      style: TextStyle(
                        fontFamily: "On",
                        color: CupertinoColors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // ==================================================
                // Login / Register Selector
                // ==================================================
                _buildSegmentedControl(),

                const SizedBox(height: 35),

                // ==================================================
                // فرم
                // ==================================================
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,

                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axisAlignment: -1,
                            child: child,
                          ),
                        );
                      },

                  child: selected == 1
                      ? _buildLoginForm()
                      : _buildRegisterForm(),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Segmented Control
  // ============================================================

  Widget _buildSegmentedControl() {
    return SizedBox(
      width: double.infinity,

      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: selected,

        thumbColor: CupertinoColors.activeBlue,

        backgroundColor: const Color(0xFF141B2E),

        children: const {
          0: Padding(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),

            child: Text(
              "ثبت نام",
              style: TextStyle(fontFamily: "On", fontSize: 20),
            ),
          ),

          1: Padding(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),

            child: Text(
              "ورود",
              style: TextStyle(fontFamily: "On", fontSize: 20),
            ),
          ),
        },

        onValueChanged: (value) {
          if (value == null) return;

          setState(() {
            selected = value;
          });

          // وقتی فرم تغییر کرد، فوکوس قبلی را بردار
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  // ============================================================
  // Login Form
  // ============================================================

  Widget _buildLoginForm() {
    return Column(
      key: const ValueKey("login-form"),

      children: [
        // شماره تلفن
        _buildPhoneField(),

        const SizedBox(height: 20),

        // رمز عبور
        _buildPasswordField(),

        const SizedBox(height: 35),

        // دکمه ورود
        _buildLoginButton(),

        const SizedBox(height: 18),

        // OTP / Forgot Password
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text(
                "ارسال مجدد کد",
                style: TextStyle(
                  fontFamily: 'On',
                  fontSize: 25,
                  fontWeight: FontWeight(600),
                ),
              ),
              onPressed: () => {},
            ),
            Container(
              width: 1,
              height: 16,
              color: CupertinoColors.extraLightBackgroundGray,
            ),
            CupertinoButton(
              child: Text(
                "فراموشی رمز عبور",
                style: TextStyle(
                  fontFamily: 'On',
                  fontSize: 25,
                  fontWeight: FontWeight(600),
                ),
              ),
              onPressed: () => {},
            ),
          ],
        ),

        const SizedBox(height: 10),

        // قوانین
        _buildTerms(),
      ],
    );
  }

  // ============================================================
  // Register Form
  // ============================================================

  Widget _buildRegisterForm() {
    return Column(
      key: const ValueKey("register-form"),

      children: [
        // نام
        _buildNameField(),

        const SizedBox(height: 20),

        // شماره تلفن
        _buildPhoneField(),

        const SizedBox(height: 20),

        // رمز عبور
        _buildPasswordField(),

        const SizedBox(height: 20),

        // تکرار رمز
        _buildConfirmPasswordField(),

        const SizedBox(height: 35),

        // دکمه ثبت نام
        _buildRegisterButton(),

        const SizedBox(height: 15),

        // قوانین
        _buildTerms(),
      ],
    );
  }

  // ============================================================
  // Name Field
  // ============================================================

  Widget _buildNameField() {
    return _fieldContainer(
      child: CupertinoTextField(
        controller: nameController,
        focusNode: nameFocus,

        textAlign: TextAlign.left,

        keyboardType: TextInputType.name,

        cursorColor: CupertinoColors.inactiveGray,

        style: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.white,
          fontSize: 17,
        ),

        placeholder: "نام و نام خانوادگی",

        placeholderStyle: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.systemGrey,
          fontSize: 20,
        ),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        decoration: const BoxDecoration(),

        prefix: const Padding(
          padding: EdgeInsets.only(left: 18),

          child: Icon(
            CupertinoIcons.person,
            color: CupertinoColors.inactiveGray,
            size: 22,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Phone Field
  // ============================================================

  Widget _buildPhoneField() {
    return _fieldContainer(
      child: CupertinoTextField(
        controller: phoneController,
        focusNode: phoneFocus,

        keyboardType: TextInputType.phone,

        textAlign: TextAlign.left,

        cursorColor: CupertinoColors.inactiveGray,

        style: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.white,
          fontSize: 17,
        ),

        placeholder: "شماره تلفن همراه",

        placeholderStyle: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.systemGrey,
          fontSize: 20,
        ),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        decoration: const BoxDecoration(),

        prefix: const Padding(
          padding: EdgeInsets.only(left: 18),

          child: Icon(
            CupertinoIcons.phone,
            color: CupertinoColors.inactiveGray,
            size: 22,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Password Field
  // ============================================================

  Widget _buildPasswordField() {
    return _fieldContainer(
      child: CupertinoTextField(
        controller: passwordController,
        focusNode: passwordFocus,

        obscureText: obscurePassword,

        textAlign: TextAlign.left,

        cursorColor: CupertinoColors.inactiveGray,

        style: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.white,
          fontSize: 17,
        ),

        placeholder: "رمز عبور",

        placeholderStyle: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.systemGrey,
          fontSize: 20,
        ),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        decoration: const BoxDecoration(),

        prefix: const Padding(
          padding: EdgeInsets.only(left: 18),

          child: Icon(
            CupertinoIcons.lock,
            color: CupertinoColors.inactiveGray,
            size: 22,
          ),
        ),

        suffix: CupertinoButton(
          padding: const EdgeInsets.only(right: 18),

          minSize: 0,

          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },

          child: Icon(
            obscurePassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye,

            color: CupertinoColors.inactiveGray,

            size: 22,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Confirm Password
  // ============================================================

  Widget _buildConfirmPasswordField() {
    return _fieldContainer(
      child: CupertinoTextField(
        controller: confirmPasswordController,
        focusNode: confirmPasswordFocus,

        obscureText: obscureConfirmPassword,

        textAlign: TextAlign.left,

        cursorColor: CupertinoColors.inactiveGray,

        style: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.white,
          fontSize: 17,
        ),

        placeholder: "تکرار رمز عبور",

        placeholderStyle: const TextStyle(
          fontFamily: "On",
          color: CupertinoColors.systemGrey,
          fontSize: 20,
        ),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        decoration: const BoxDecoration(),

        prefix: const Padding(
          padding: EdgeInsets.only(left: 18),

          child: Icon(
            CupertinoIcons.lock_fill,
            color: CupertinoColors.inactiveGray,
            size: 22,
          ),
        ),

        suffix: CupertinoButton(
          padding: const EdgeInsets.only(right: 18),

          minSize: 0,

          onPressed: () {
            setState(() {
              obscureConfirmPassword = !obscureConfirmPassword;
            });
          },

          child: Icon(
            obscureConfirmPassword
                ? CupertinoIcons.eye_slash
                : CupertinoIcons.eye,

            color: CupertinoColors.inactiveGray,

            size: 22,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Field Container
  // ============================================================

  Widget _fieldContainer({required Widget child}) {
    return Container(
      height: 70,

      decoration: BoxDecoration(
        color: const Color(0xFF141B2E),

        borderRadius: BorderRadius.circular(12),
      ),

      child: child,
    );
  }

  // ============================================================
  // Login Button
  // ============================================================

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,

      child: CupertinoButton.filled(
        padding: const EdgeInsets.symmetric(vertical: 15),

        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const AuthXApp()),
          );
        },

        child: const Text(
          "ورود",

          style: TextStyle(
            fontFamily: "On",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Register Button
  // ============================================================

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,

      child: CupertinoButton.filled(
        padding: const EdgeInsets.symmetric(vertical: 15),

        onPressed: () {
          // منطق ثبت نام
        },

        child: const Text(
          "ثبت نام",

          style: TextStyle(
            fontFamily: "On",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Terms
  // ============================================================

  Widget _buildTerms() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,

      children: [
        const Text(
          ".را می‌پذیرید",

          style: TextStyle(
            fontFamily: "On",
            fontSize: 20,
            color: Color.fromARGB(255, 192, 192, 202),
          ),
        ),

        CupertinoButton(
          padding: EdgeInsets.zero,

          minSize: 0,

          onPressed: () {},

          child: const Text(
            " شرایط",

            style: TextStyle(
              fontFamily: "On",
              fontSize: 20,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ),

        const Text(
          " و ",

          style: TextStyle(
            fontFamily: "On",
            fontSize: 20,
            color: Color.fromARGB(255, 192, 192, 202),
          ),
        ),

        CupertinoButton(
          padding: EdgeInsets.zero,

          minSize: 0,

          onPressed: () {},

          child: const Text(
            "قوانین",

            style: TextStyle(
              fontFamily: "On",
              fontSize: 20,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ),

        const Text(
          " با ورود یا ثبت نام",

          style: TextStyle(
            fontFamily: "On",
            fontSize: 20,
            color: Color.fromARGB(255, 192, 192, 202),
          ),
        ),
      ],
    );
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
}
