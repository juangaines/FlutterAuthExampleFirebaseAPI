import 'package:firebase_api_example_auth/auth_firebase_%20provider.dart';
import 'package:firebase_api_example_auth/model/error_firebase.dart';
import 'package:firebase_api_example_auth/model/login_user.dart';
import 'package:firebase_api_example_auth/routes/MapRoute.dart';
import 'package:firebase_api_example_auth/utils_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter_hms_gms_availability/flutter_hms_gms_availability.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthFirebaseProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isHms;
  AuthFirebaseProvider authFirebaseProvider;
  String _email = "";
  String _password = "";

  final _formKey = GlobalKey<FormState>();

  void _signUpOrLogin(
      BuildContext context, String email, String password) async {
    //authFirebaseProvider?.signUpUser("jdgpdtse90@gmail.com", "huawei123");
    final customeResponse =
        await authFirebaseProvider?.loginUser(email, password);
    if (customeResponse != null && customeResponse.object != null) {
      final jsonV = json.decode(customeResponse.object);
      final loginUser = LogInUserResponse.fromJson(jsonV);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapRoute()),
      );
    } else {
      ErrorResponse er = customeResponse.error;

      final snackBar = SnackBar(content: Text('${er.error.message}'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _getHmsOrGms() async {
    _isHms = await Utils.checkHms();
    authFirebaseProvider = Provider.of(context, listen: false);
  }

  @override
  void initState() {
    _getHmsOrGms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  initialValue: _email,
                  onChanged: (value) {
                    _email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _password,
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length <= 5) {
                      return 'Password must be at least 5 chars long';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.

                        _signUpOrLogin(context, _email, _password);
                      }
                    },
                    child: Text('Submit'),
                  ),
                )
              ],
            ) // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
