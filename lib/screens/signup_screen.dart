import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/authentication.dart';
import 'home_screen.dart';
import 'login_screen.dart';



class SignupScreen extends StatefulWidget {
  static const routeName ='/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey =GlobalKey();
  TextEditingController _passwordController =new TextEditingController();
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
      await Provider.of<Authentication>(context, listen:false).signUp(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(Home.routeName);
    }
    catch(error){
      var errorMessage= 'Authentication Failed. Please try again';
      _showErrorDialog(errorMessage);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[

                  //Icon(Icons.person),
                // Text('Log in ')
                ],
              ),
              textColor: Colors.white,
              onPressed:(){
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              },
            ),

          ],
        ),
    body: Stack (
    children: <Widget>[

    Container(
        padding: EdgeInsets.fromLTRB(50.0, 80.0, 0.0, 100.0),
      child: Text(
        'HELLO THERE',
        style:
        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
      ),
    ),

   Container(
    padding: EdgeInsets.fromLTRB(310.0, 43.0, 0.0, 0.0),
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
      padding: EdgeInsets.fromLTRB(50.0, 40.0, 50.0, 0.0),

    width:300,


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
    controller: _passwordController,
    validator: (value)
    {
    if(value.isEmpty || value.length<=5)
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
    //Confirm Password
    TextFormField(
    decoration: InputDecoration(labelText: 'Confirm Password'),
    obscureText: true,
    validator: (value)
    {
    if(value.isEmpty || value != _passwordController.text)
    {
    return 'invalid password';
    }
    return null;

    },
    onSaved: (value)
    {

    },
    ),
    SizedBox(
    height: 30,


    ),
    RaisedButton(

    child:Text(
    'Submit'
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
    ),
    //SizedBox(height: 15.0),


    Text(
    'Already A user?',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 2,

      ),
    ),

      FlatButton(
        child: Text('Log In',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline)),
        textColor: Colors.white,
        onPressed:(){
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        },
      ),

    ],

    ),

    ),
    ),
    ),
    )

    ),


    ],

    ));}}




