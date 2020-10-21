import 'package:flutter/material.dart';
import'package:provider/provider.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import '../models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName ='/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey =GlobalKey();
  Map<String, String>_authData={
    'email':'',
    'password': '',
  };
  void _showErrorDialog(String msg)
  {
    showDialog(context:context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured'),
        content:Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('okay'),
              onPressed: (){
               Navigator.of(ctx).pop();
              },
          )
        ],
      )
    );


  }

  Future<void> _submit() async
  {
if(!_formKey.currentState.validate())
  {
    return;
  }
  _formKey.currentState.save();
try{
  await Provider.of<Authentication>(context, listen:false).logIn(
      _authData['email'],
      _authData['password']
  );
  Navigator.of(context).pushReplacementNamed(Home.routeName);
}catch(error)
    {
    var errorMessage= 'Authentication Failed. Please try again';
    _showErrorDialog(errorMessage);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[

              Icon(Icons.arrow_back_ios_outlined),
                Text('Back')
              ],
          ),
          textColor: Colors.white,
          onPressed:(){
          Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
        },
            ),

        ],

      ),
        resizeToAvoidBottomPadding: false,
        body: Stack (
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(80.0, 80.0, 0.0, 0.0),
              child: Text(
                'LOG IN',
                style:
                TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(210.0, 43.0, 0.0, 0.0),
              child: Text(
                '.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),),
            Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child:Container(
                    height: 260,
                    width:300,
                    padding: EdgeInsets.all(16),
                    child : Form(
                      key: _formKey ,
                      child:SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //email
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              validator:(value){
                                if(value.isEmpty || value.contains('0'))
                                {
                                  return 'invalid email';
                                }
                                return null;
                              } ,
                              onSaved: (value)
                              {
                                _authData['email']=value;
                              },
                            ),

                            //password
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              validator: (value)
                              {
                                if(value.isEmpty || value.contains('0'))
                                {
                                  return 'invalid password';
                                }
                                return null;

                              },
                              onSaved: (value)
                              {
                                _authData['password']=value;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              child:Text(
                                  'Log In'
                              ) ,
                              onPressed: ()
                              {
                                _submit();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(30),
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                            )
                          ],

                        ),
                      ),
                    ),
                  ),
                )
            )
          ],
        )
    );
  }
}


