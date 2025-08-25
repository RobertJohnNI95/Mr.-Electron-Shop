import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final String label;
  final TextInputType keboardType;
  final bool isPass;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const FormInput({
    super.key,
    required this.label,
    required this.keboardType,
    required this.validator,
    this.isPass = false,
    this.controller,
  });

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator!,
        obscureText: widget.isPass ? isObscure : false,
        obscuringCharacter: '*',
        keyboardType: widget.keboardType,
        decoration: InputDecoration(
          suffixIcon: widget.isPass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure
                      ? Icon(Icons.visibility_off_outlined)
                      : Icon(Icons.visibility_outlined),
                )
              : null,
          label: Text(
            widget.label,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
