import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Login"),
                TextFormField(
                  controller: _userController,
                  decoration: InputDecoration(
                    hintText: "Usuario",
                  ),
                ),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    Navigator.pushNamed(context, '/list');
                  }
                  else{
                    print("No validado");
                  }
                }, child: Text("Login"))
              ],
            )
        ),
      ),
    );
  }
}
