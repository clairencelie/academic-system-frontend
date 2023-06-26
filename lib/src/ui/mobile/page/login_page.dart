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
                const LoginHeader(),
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
                MobileUsernameField(id: id, focus1: _focus1),
                const SizedBox(
                  height: 10,
                ),
                MobilePasswordField(password: password, focus2: _focus2),
                const Flexible(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                MobileLogin(formKey: formKey, id: id, password: password),
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

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

class MobileUsernameField extends StatelessWidget {
  const MobileUsernameField({
    Key? key,
    required this.id,
    required FocusNode focus1,
  })  : _focus1 = focus1,
        super(key: key);

  final TextEditingController id;
  final FocusNode _focus1;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class MobilePasswordField extends StatelessWidget {
  const MobilePasswordField({
    Key? key,
    required this.password,
    required FocusNode focus2,
  })  : _focus2 = focus2,
        super(key: key);

  final TextEditingController password;
  final FocusNode _focus2;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class MobileLogin extends StatelessWidget {
  const MobileLogin({
    Key? key,
    required this.formKey,
    required this.id,
    required this.password,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController id;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainPage(user: state.user);
              },
            ),
          );
        } else if (state is LoginFailed) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Informasi'),
                content: const Text(
                    'Username atau password yang anda masukan salah.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Tutup'),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const MobileSignInButton(
            onTap: null,
            widget: Center(
              child: SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
        if (state is LoginFailed) {
          return MobileSignInButton(
            onTap: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                      Login(
                        id: id.text,
                        password: password.text,
                      ),
                    );
              }
            },
          );
        }
        return MobileSignInButton(
          onTap: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(
                    Login(
                      id: id.text,
                      password: password.text,
                    ),
                  );
            }
          },
        );
      },
    );
  }
}
