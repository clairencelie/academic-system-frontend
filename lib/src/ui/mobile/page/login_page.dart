import 'package:academic_system/src/bloc/auth/auth_bloc.dart';
import 'package:academic_system/src/ui/mobile/component/button/sign_in_button.dart';
import 'package:academic_system/src/ui/mobile/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({super.key});

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();

  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus1.addListener(_onFocusChange);
    _focus2.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus1.removeListener(_onFocusChange);
    _focus2.removeListener(_onFocusChange);
    _focus1.dispose();
    _focus2.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 45),
                    height: 124,
                    width: 129,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(17, 0, 0, 0),
                          blurRadius: 10,
                          spreadRadius: 0.1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/img/logo/logo.png'),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 0, 32, 96),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'NIM/NIP belum diisi!';
                    } else if (int.tryParse(value) is! int) {
                      return 'NIM/NIP tidak boleh berisi huruf!';
                    } else {
                      return null;
                    }
                  },
                  controller: id,
                  cursorColor: const Color.fromARGB(255, 0, 32, 96),
                  focusNode: _focus1,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 32, 96),
                      ),
                    ),
                    hintText: 'Masukkan NIM/NIP...',
                    labelText: 'NIM/NIP',
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      color: _focus1.hasFocus
                          ? const Color.fromARGB(255, 0, 32, 96)
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password belum diisi!';
                    } else {
                      return null;
                    }
                  },
                  controller: password,
                  obscureText: true,
                  cursorColor: const Color.fromARGB(255, 0, 32, 96),
                  focusNode: _focus2,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 32, 96),
                      ),
                    ),
                    hintText: 'Masukkan password...',
                    labelText: 'Password',
                    contentPadding: EdgeInsets.zero,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      color: _focus2.hasFocus
                          ? const Color.fromARGB(255, 0, 32, 96)
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
                const Flexible(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      // TODO: Make loading animation
                    } else if (state is AuthSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainPage(user: state.user);
                          },
                        ),
                      );
                    } else if (state is LoginFailed) {
                      // TODO: Make login failed dialog information
                    }
                  },
                  child: MobileSignInButton(
                    onTap: () {
                      // If valid, navigate to home screen.
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              Login(
                                id: id.text,
                                password: password.text,
                              ),
                            );
                      }
                    },
                  ),
                ),
                const Flexible(
                  child: SizedBox(
                    height: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
