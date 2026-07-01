import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../lib/app/theme/theme/app_colors.dart';
import '../../../app/widgets/primary_button.dart';
import '../../../app/widgets/tribal_divider.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 4),
                child: TextButton(
                  onPressed: controller.skipForNow,
                  child: const Text(
                    'Skip for Now',
                    style: TextStyle(
                      color: AppColors.terracotta,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppColors.terracotta, AppColors.ochre],
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_stories_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Text(
                        controller.isLoginMode.value
                            ? 'Welcome back'
                            : 'Join Afrolore',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in to sync your saved stories, history and offline downloads across devices.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 26),
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _fieldDecoration(
                        context,
                        Icons.mail_outline_rounded,
                        'you@example.com',
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextField(
                        controller: controller.passwordController,
                        obscureText: controller.obscurePassword.value,
                        decoration:
                            _fieldDecoration(
                              context,
                              Icons.lock_outline_rounded,
                              '••••••••',
                            ).copyWith(
                              suffixIcon: IconButton(
                                onPressed: controller.toggleObscure,
                                icon: Icon(
                                  controller.obscurePassword.value
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  size: 20,
                                ),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Obx(
                      () => PrimaryButton(
                        label: controller.isLoginMode.value
                            ? 'Log In'
                            : 'Create Account',
                        isLoading: controller.isLoading.value,
                        onPressed: controller.submit,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const TribalDivider(),
                    Center(
                      child: Text(
                        'or continue with',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _SocialButton(
                            label: 'Google',
                            icon: Icons.g_mobiledata_rounded,
                            onTap: () => controller.socialLogin('Google'),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _SocialButton(
                            label: 'Apple',
                            icon: Icons.apple_rounded,
                            onTap: () => controller.socialLogin('Apple'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Center(
                      child: Obx(
                        () => GestureDetector(
                          onTap: controller.toggleMode,
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: controller.isLoginMode.value
                                      ? "Don't have an account? "
                                      : 'Already have an account? ',
                                ),
                                TextSpan(
                                  text: controller.isLoginMode.value
                                      ? 'Sign Up'
                                      : 'Log In',
                                  style: const TextStyle(
                                    color: AppColors.terracotta,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(
    BuildContext context,
    IconData icon,
    String hint,
  ) {
    return InputDecoration(
      prefixIcon: Icon(icon, size: 20),
      hintText: hint,
      filled: true,
      fillColor: Theme.of(context).cardColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.ochre.withValues(alpha: 0.25)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.ochre.withValues(alpha: 0.25)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: AppColors.terracotta, width: 1.6),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: BorderSide(color: AppColors.ochre.withValues(alpha: 0.35)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
