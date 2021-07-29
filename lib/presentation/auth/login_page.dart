import 'package:flutter/material.dart';
import 'package:fluttercrud/application/models/auth/login_form_model.dart';
import 'package:fluttercrud/router/route_constants.dart';
import 'package:fluttercrud/values/branding_color.dart';
import 'package:fluttercrud/values/images.dart';
import 'package:fluttercrud/widgets/show_snackbar.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        inject: [Inject<LoginFormModel>(() => LoginFormModel())],
        builder: (context) {
          final _singletonLoginFormModel = RM.get<LoginFormModel>();
          return Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 250,
                  child: Center(
                    child: Image.asset(Images.logo),
                  ),
                ),
                StateBuilder<LoginFormModel>(
                  shouldRebuild: (_) => true,
                  builder: (context, loginFormModel) {
                    return TextFormField(
                      onChanged: (String email) {
                        loginFormModel.setState(
                            (state) => state.setEmail(email),
                            catchError: true);
                      },
                      decoration: InputDecoration(
                        errorText: loginFormModel.hasError
                            ? loginFormModel.error.message
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
                StateBuilder<LoginFormModel>(
                  shouldRebuild: (_) => true,
                  builder: (_, loginFormModel) {
                    return TextFormField(
                      onChanged: (String password) {
                        loginFormModel.setState(
                            (state) => state.setPassword(password),
                            catchError: true);
                        print(loginFormModel.hasError);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: loginFormModel.hasError
                            ? loginFormModel.error.message
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
                buildSizedBox(25),
                StateBuilder(
                  observe: () => _singletonLoginFormModel,
                  builder: (_, loginFormModel) {
                    return MaterialButton(
                      onPressed: () {
                        // print(_singletonLoginFormModel.state.validateData());
                        if (!_singletonLoginFormModel.state.validateData()) {
                          showSnackbar(
                              color: Colors.red,
                              key: _key,
                              message:
                                  "Data is invalid, please fill the form before submitting!");
                        } else {
                          _singletonLoginFormModel.setState(
                            (loginFormState) async {
                              await loginFormState.submitLogin();
                              Navigator.pushNamed(context, homeRoute);
                            },
                            onError: (context, error) => showSnackbar(
                                color: Colors.red,
                                key: _key,
                                message: "${error.message}"),
                          );
                        }
                      },
                      height: 55,
                      shape: StadiumBorder(),
                      color: brandingColor,
                      child: Center(
                        child: Text(
                          "Login",
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
                    Text("Don't have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, registerRoute);
                        },
                        child: Text(
                          "Register",
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
