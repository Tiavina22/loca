import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loca/core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulation d'une connexion
      await Future.delayed(const Duration(seconds: 2));

      // Vérification simple des identifiants (à remplacer par une vraie auth)
      if (_emailController.text == "test@test.com" &&
          _passwordController.text == "password123") {
        // Redirection vers la page d'accueil
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRouter.home);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email ou mot de passe incorrect'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        _buildHeader(),
                        const SizedBox(height: 40),
                        _buildForm(),
                        const Spacer(),
                        _buildBottomSection(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 74),
        Text(
          'Bienvenue sur Loca',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: AppColors.textHintColor),
          prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    onPressed:
                        () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        ),
                  )
                  : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
        ),
        obscureText: isPassword && !_isPasswordVisible,
        style: TextStyle(color: AppColors.textPrimaryColor),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _emailController,
            placeholder: 'Email',
            icon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              if (!value.contains('@')) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _passwordController,
            placeholder: 'Mot de passe',
            icon: Icons.lock_outline,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre mot de passe';
              }
              if (value.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextButton(
            child: Text(
              'Mot de passe oublié ?',
              style: TextStyle(color: AppColors.textPrimaryColor),
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child:
                  _isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : const Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.white),
                      ),
              onPressed: _isLoading ? null : _handleSignIn,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.register),
            child: Text(
              'Pas encore de compte ? S\'inscrire',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: CupertinoColors.systemGrey4.resolveFrom(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ou',
                style: TextStyle(
                  color: CupertinoColors.systemGrey.resolveFrom(context),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: CupertinoColors.systemGrey4.resolveFrom(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: CupertinoColors.systemGrey6.resolveFrom(context),
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logos/logo-google.png', height: 24),
              const SizedBox(width: 12),
              Text(
                'Continuer avec Google',
                style: TextStyle(
                  color: CupertinoColors.label.resolveFrom(context),
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
