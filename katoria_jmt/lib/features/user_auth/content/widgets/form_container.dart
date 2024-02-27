import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormContainerWidget extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final Key? fieldKey;
  final bool? isPassword;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget(
      {this.hintText,
      this.labelText,
      this.helperText,
      this.fieldKey,
      this.isPassword,
      this.controller,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType});

  @override
  _FormContainerWidgetState createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.red),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPassword == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPassword == true
                ? Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText == false ? Colors.blue : Colors.grey,
                  )
                : Text(' '),
          ),
        ),
      ),
    );
  }
}
