import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name;
  String _email;
  String _passworld;
  String _url;
  String _phoneNumber;
  String _confirmpassword;

  String groupvalue = "male";
  bool hidepass = true;

  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController =TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPassworldController = TextEditingController();
  TextEditingController _nameTextController =TextEditingController();
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:ListTile(title: TextFormField(
        decoration: InputDecoration(
          hintText: 'Name',
          icon: Icon(Icons.person),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
        onSaved: (String value) {
          _name = value;
        },
      ),
    ));
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(title: TextFormField(
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(Icons.email),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is  Required';
          }

          if (!RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return 'Please enter a valid email Address';
          }
          return null;
        },
        onSaved: (String value) {
          _email = value;
        },
      ),
    ));
  }

  Widget _buildPassworld() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile( title: TextFormField(
        controller: _passwordTextController,
        obscureText: hidepass,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(Icons.lock_outline),
        //  border: InputBorder.none
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (String value) {
          if (value.isEmpty) {
            return 'password is  Required';
          }else if (value.length<6){
            return"the password has to be at least 6 character";
          }
        },
        onSaved: (String value) {
          _passworld = value;
        },
      ),
      trailing: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){
        setState(() {
          hidepass = !hidepass;
        });
      }),
    ));
    
  }

  Widget _buildURL() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Url',
        icon: Icon(Icons.lock_outline),

      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Url is  Required';
        }
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:ListTile(title: TextFormField(
        decoration: InputDecoration(
          hintText: 'phone number',
          icon: Icon(Icons.phone),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Phone  is  Required';
          }
        },
        onSaved: (String value) {
          _phoneNumber = value;
        },
      ),
    ));
  }

  Widget _buildconfirmPassworld() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:ListTile(title: TextFormField(
        controller: _confirmPassworldController,
        obscureText: hidepass,
        decoration: InputDecoration(
          hintText: 'Confirm Password',
          icon: Icon(Icons.lock_outline),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (String value) {
          if (value.isEmpty) {
            return 'password is  Required';
          }else if (value.length<6){
            return("the passworld must be at least 6 character");
          }
          else if(_confirmPassworldController.text != _passwordTextController.text){
            return("the  passworld don't match");
          }
        },
        onSaved: (String value) {
          _passworld = value;
        },
      ),
      trailing: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){
        setState(() {
          hidepass = !hidepass;
        });
      }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('sign up'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildName(),
                  _buildEmail(),

                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: new Container(
                      color:Colors.white.withOpacity(.5),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "male",
                               textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.blue),
                            ),
                            trailing: Radio(
                                value: "male",
                                groupValue: groupvalue,
                                onChanged: (e) => valueChanged(e)),
                          ),
                        ),
                                Expanded(
                          child: ListTile(
                            title: Text(
                              "female",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.blue),
                            ),
                            trailing: Radio(
                                value: "female",
                                groupValue: groupvalue,
                                onChanged: (e) => valueChanged(e)),
                          ),
                        ),
          
                      ]),
                    ),
                 ),
                  _buildPassworld(),
                  _buildconfirmPassworld(),
                 // _buildURL(),
                  // _buildCalories(),
                  _buildPhoneNumber(),

                  Divider(),

                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    onPressed: () {

                          validateForm();
                          
                                              // if (!_formKey.currentState.validate()) {
                                              //     return;
                                              //   }
                                              //   _formKey.currentState.save();
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) => new HomePage()));
                                               },
                                            ),
                          
                                            Row(children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(40),
                                                child: InkWell(
                                                  child: new Text(
                                                    "already have an account",
                                                    style: TextStyle(
                                                        color: Colors.red.shade900,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  // onTap: () {
                                                  //   Navigator.push(
                                                  //       context,
                                                  //       MaterialPageRoute(
                                                  //      //     builder: (context) => new Login()));
                                                  // },
                                                ),
                                              )
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          
                            valueChanged(e) {
                              setState(() {
                                if (e == "male") {
                                  groupvalue = e;
                                 
                                } else if (e == "female") {
                                  groupvalue = e;
                                  
                                }
                              });
                            }
                          
                            void validateForm() {
                              FormState formState =_formKey.currentState;
                              if (formState.validate()){

                              }
                            }
}
