import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presantation/auth/pages/signin.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : AppColors.lightbackground,
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.spotifyLogo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'If You Need Any Support ',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                    fontSize: 13,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Click Here',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _textField(context, 'Full Name', isDarkMode),
            const SizedBox(height: 20),
            _textField(context, 'Enter Email', isDarkMode),
            const SizedBox(height: 20),
            _textField(context, 'Password', isDarkMode, isPassword: true),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: isDarkMode ? Colors.white24 : Colors.black26,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white.withValues(alpha: 0.5) : Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: isDarkMode ? Colors.white24 : Colors.black26,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(Icons.g_mobiledata_rounded, isDarkMode, color: Colors.blue), // 'Google' standalone representation placeholder
                const SizedBox(width: 40),
                _socialIcon(Icons.apple, isDarkMode), // Apple
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do You Have An Account? ',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white.withValues(alpha: 0.7) : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SigninPage()),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(BuildContext context, String hint, bool isDarkMode, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.white30 : Colors.black38,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white30 : Colors.black38,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white30 : Colors.black38,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        suffixIcon: isPassword
            ? Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.visibility_off,
                  color: isDarkMode ? Colors.white30 : Colors.black38,
                ),
              )
            : null,
      ),
    );
  }

  Widget _socialIcon(IconData icon, bool isDarkMode, {Color? color}) {
    return icon == Icons.g_mobiledata_rounded 
        ? Image.asset(
           AppImages.googleLogo,
           height: 30,
          )
        : Icon(
            icon,
            size: 35,
            color: color ?? (isDarkMode ? Colors.white : Colors.black),
          );
  }
}