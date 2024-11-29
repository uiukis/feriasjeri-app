import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feriasjeri_app/utils/validators.dart';
import 'package:feriasjeri_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return 'Usuário não encontrado';
      }
      return 'Erro: ${e.message}';
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );

      await FirebaseFirestore.instance.collection('users').doc(data.name).set({
        'uid': userCredential.user!.uid,
        'isAdmin': false,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email já está em uso';
      } else if (e.code == 'weak-password') {
        return 'Senha muito fraca';
      }
      return 'Erro: ${e.message}';
    }
  }

  Future<String?> _recoverPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return 'Erro ao recuperar senha: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Ferias Jeri',
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      userValidator: emailValidator,
      passwordValidator: passwordValidator,
      theme: LoginTheme(
        accentColor: Colors.white,
      ),
      messages: LoginMessages(
        userHint: 'E-mail',
        passwordHint: 'Senha',
        confirmPasswordHint: 'Confirme sua senha',
        forgotPasswordButton: 'Esqueceu sua senha?',
        loginButton: 'Entrar',
        signupButton: 'Cadastrar',
        recoverPasswordButton: 'Recuperar',
        goBackButton: 'Voltar',
        confirmPasswordError: 'As senhas não conferem',
        recoverPasswordIntro: 'Redefina sua senha aqui',
        recoverPasswordDescription: 'Enviaremos um e-mail para recuperação',
        recoverPasswordSuccess: 'E-mail de recuperação enviado com sucesso',
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
    );
  }
}
