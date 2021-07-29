import 'package:flutter/material.dart';
import 'package:fluttercrud/application/models/auth/register_form_model.dart';
import 'package:fluttercrud/router/route_constants.dart';
import 'package:fluttercrud/values/branding_color.dart';
import 'package:fluttercrud/values/images.dart';
import 'package:fluttercrud/widgets/show_snackbar.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: Injector(
        inject: [Inject<RegisterFormModel>(() => RegisterFormModel())],
        builder: (context) {
          final _singletonRegisterFormModel = RM.get<RegisterFormModel>();
          return Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  child: Center(
                    child: Image.asset(Images.logo),
                  ),
                ),
                StateBuilder<RegisterFormModel>(
                  builder: (context, registerFormModel) {
                    return TextFormField(
                      onChanged: (String name) {
                        registerFormModel.setState((s) => s.setName(name),
                            catchError: true);
                      },
                      decoration: InputDecoration(
                        errorText: registerFormModel.hasError
                            ? registerFormModel.error.message
                            : null,
                        prefixIcon: Icon(Icons.person),
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    );
                  },
                ),
                buildSizedBox(15),
                StateBuilder<RegisterFormModel>(
                  builder: (context, registerFormModel) {
                    return TextFormField(
                      onChanged: (String email) {
                        registerFormModel.setState((s) => s.setEmail(email),
                            catchError: true);
                      },
                      decoration: InputDecoration(
                        errorText: registerFormModel.hasError
                            ? registerFormModel.error.message
                            : null,
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    );
                  },
                ),
                buildSizedBox(15),
                StateBuilder<RegisterFormModel>(
                  builder: (_, registerFormModel) {
                    return TextFormField(
                      onChanged: (String password) {
                        registerFormModel.setState(
                            (s) => s.setPassword(password),
                            catchError: true);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: registerFormModel.hasError
                            ? registerFormModel.error.message
                            : null,
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    );
                  },
                ),
                buildSizedBox(15),
                StateBuilder<RegisterFormModel>(
                  builder: (_, registerFormModel) {
                    return TextFormField(
                      onChanged: (String passwordConfirmation) {
                        registerFormModel.setState(
                            (state) => state
                                .setPasswordConfirmation(passwordConfirmation),
                            catchError: true);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: registerFormModel.hasError
                            ? registerFormModel.error.message
                            : null,
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter password confirmation",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    );
                  },
                ),
                buildSizedBox(25),
                StateBuilder(
                  observe: () => _singletonRegisterFormModel,
                  builder: (_, registerFormModel) {
                    return MaterialButton(
                      onPressed: () {
                        if (!_singletonRegisterFormModel.state.validateData()) {
                          showSnackbar(
                            key: _key,
                            message:
                                "Invalid data, kindly fill the form correctly!",
                            color: Colors.red,
                          );
                        } else {
                          _singletonRegisterFormModel.state.submitRegister();
                        }
                      },
                      height: 55,
                      shape: StadiumBorder(),
                      color: brandingColor,
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    );
                  },
                ),
                buildSizedBox(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Already have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, loginRoute);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: brandingColor),
                        )),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
