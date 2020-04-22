import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  final _formKey = GlobalKey<FormState>();

  String nric;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Form(
        child: Flexible(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.pinkAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2)
                  ),
                  hintText: 'Enter the last 4 digits of your NRIC'
                ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty!';
                  }
                  return null;
                },
                onSaved: (value){
                      nric = value;
                },
              ),
              RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              child: Text('Submit'),
            ),
            ],
          ),
        ),
      ),
    );

  }
}
