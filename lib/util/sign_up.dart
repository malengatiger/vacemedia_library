import 'package:flutter/material.dart';
import 'package:vacemedia_library/util/snack.dart';

import '../auth.dart';
import 'functions.dart';

class SignUp extends StatefulWidget {
  final String type;

  const SignUp({Key key, this.type}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> implements SnackBarListener {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isBusy = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('VaceMedia Platform'),
          backgroundColor: Colors.brown[400],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(140),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome! Please sign up to the VaceMedia Platform',
                    style: Styles.whiteSmall,
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.brown[100],
        body: isBusy
            ? Center(
                child: Container(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 24,
                    backgroundColor: Colors.teal[800],
                  ),
                ),
              )
            : ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Sign Up',
                              style: Styles.blackBoldLarge,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextField(
                              onChanged: _onNameChanged,
                              keyboardType: TextInputType.text,
                              controller: nameCntr,
                              decoration: InputDecoration(
                                hintText: 'Enter Name',
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              onChanged: _onEmailChanged,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailCntr,
                              decoration: InputDecoration(
                                hintText: 'Enter  email address',
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              onChanged: _onPasswordChanged,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              controller: pswdCntr,
                              decoration: InputDecoration(
                                hintText: 'Enter password',
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            RaisedButton(
                              onPressed: _signUp,
                              color: Colors.pink[700],
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Submit Sign in credentials',
                                  style: Styles.whiteSmall,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        // ignore: missing_return
      ),
      onWillPop: () => doNothing(),
    );
  }

  Future<bool> doNothing() async {
    return false;
  }

  TextEditingController emailCntr = TextEditingController();
  TextEditingController pswdCntr = TextEditingController();
  TextEditingController nameCntr = TextEditingController();
  String email, password, name;
  void _onEmailChanged(String value) {
    email = value;
    print(email);
  }

  void _signUp() async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      AppSnackbar.showErrorSnackbar(
          scaffoldKey: _key,
          message: "Credentials missing or invalid",
          actionLabel: 'Error',
          listener: this);
      return;
    }
    setState(() {
      isBusy = true;
    });
    try {
      await Auth.signIn(email: email, password: password);
      print('✳️✳️✳️✳️✳️✳️✳️ signed in ok, ✳️ popping .....');
      Navigator.pop(context, true);
    } catch (e) {
      print(e);
      setState(() {
        isBusy = false;
      });
      AppSnackbar.showErrorSnackbar(
          scaffoldKey: _key,
          message: 'We have a problem $e',
          actionLabel: 'Err',
          listener: this);
    }
  }

  void _onPasswordChanged(String value) {
    password = value;
    print(password);
  }

  void _onNameChanged(String value) {
    name = value;
    print(name);
  }

  @override
  onActionPressed(int action) {
    // TODO: implement onActionPressed
    return null;
  }
}
