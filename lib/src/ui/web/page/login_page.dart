import 'package:academic_system/src/bloc/auth/auth_bloc.dart';
import 'package:academic_system/src/ui/web/component/button/sign_in_button.dart';
import 'package:academic_system/src/ui/web/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebLoginPage extends StatefulWidget {
  const WebLoginPage({super.key});

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
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
                      "Sistem Informasi Akademik",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "STMIK Dharma Putra",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  height: 300,
                  width: 1,
                  color: const Color.fromARGB(187, 169, 183, 199),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
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
                          // prefixIcon: Icon(Icons.person, ),
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          labelText: 'NIM/NIP',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
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
                          // alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    const Flexible(
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
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
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
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
                          // alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    const Flexible(
                      child: SizedBox(
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoading) {
                            // print("loading");
                          } else if (state is AuthSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WebMainPage(user: state.user);
                                },
                              ),
                            );
                          } else if (state is LoginFailed) {
                            print(state.message);
                          }
                        },
                        child: WebSignInButton(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
