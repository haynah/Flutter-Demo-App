import 'package:flutter/material.dart';
import 'package:ph_online/userPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String username = '';
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController;
  TextEditingController _passController;
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passController = TextEditingController();
  }
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  void _success (BuildContext context) {
    String username = _usernameController.text;
    String finalusername = username.substring(0, username.indexOf('@'));
    Navigator.push(
        context,
      MaterialPageRoute(builder: (context) => userPage(username: finalusername,),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        //padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(18.0, 175.0, 0.0, 0.0),
                      child: Text(
                        'There',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green
                        ),
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                margin: EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    if (!value.contains('@')) {
                      return "A valid email should contain '@'";
                    }
                    if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    // if(value != 'admin@rejolut.com') {
                    //   return "We have never seen this username";
                    // }
                  },
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green
                        )
                    ),
                    labelText: 'Username',
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                margin: EdgeInsets.all(4.0),
                child: TextFormField(
                  obscureText: true,
                    controller: _passController,
                    keyboardType: TextInputType.visiblePassword,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field is required';
                      }
                      if (value.length < 8) {
                        return 'Password should have atleast 8 characters';
                      }
                      if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(value)) {
                        return 'Password must contain uppercase & lowercase characters, numbers, and special character';
                      }
                    },
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green
                          )
                      ),
                      labelText: 'Password',
                    ),
                    // onSaved: (String value) {
                    //   this._data.phone = value;
                    // }
                ),
              ),
              new Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green),
                      ),
                      child: new Text(
                        'Login',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 17.0
                        ),
                      ),
                      onPressed: () {
                        if(!_formKey.currentState.validate()) {
                          return;
                        }
                        _success(context);
                      },
                      color: Colors.green,
                    )
                ),
              ),
              /*new Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Image.asset('assets/images/background.png'),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.green),)
                      ]),
                    )
                  ]));
        });
  }
}