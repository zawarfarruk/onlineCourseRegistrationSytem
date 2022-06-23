

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);
  bool isLoading;
  final void Function(String userName, String email, String password,
      bool isLogin, BuildContext ctx) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formState = GlobalKey<FormState>();
  var _isLogin = true;
  var _userName = " ";
  var _email = " ";
  var _password = " ";
  void _tryToSubmit() {
    final isValid = _formState.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formState.currentState!.save();
      widget.submitFn(_userName, _email, _password, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formState,
              child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey("User Name"),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Please Enter Name";
                          }
                          return null;
                        }),
                        decoration:
                            const InputDecoration(labelText: "User Name"),
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _userName = value!;
                        },
                      ),
                    TextFormField(
                      key: const ValueKey("Email"),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "Please enter valid Email Address";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    TextFormField(
                      key: const ValueKey("Password"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return "Please Entrer more than 6 Character";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(labelText: "Password"),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (widget.isLoading) const CircularProgressIndicator(),
                    ElevatedButton(
                        onPressed: _tryToSubmit,
                        child: Text(_isLogin ? " Login " : "SignUp")),
                    if (!widget.isLoading)
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? "Create account "
                              : "I have already account")),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
