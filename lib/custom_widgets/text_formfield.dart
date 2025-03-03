import 'package:flutter/material.dart';
class TextformField extends StatelessWidget {
   const TextformField(this.hintText, this.textIcon, this.obscureText, this.validator, this.keyboard, this.textEditingController, {super.key});
  final String hintText;
  final Icon textIcon;
  final bool obscureText;
   final String? Function(String?)? validator;
   final TextInputType? keyboard;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboard,
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: textIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
