import "package:flutter/material.dart";

InputBorder _buildTextFieldBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      color: Color(0xff1A1A1A),
      width: 1,
    )
  );
}

InputDecoration _buildInputDecoration() {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
    enabledBorder: _buildTextFieldBorder(),
    focusedBorder: _buildTextFieldBorder()
  );
}

Widget buildTextField(String text, TextEditingController controller, FocusNode focusNode, ValueChanged onChanged) {
  return Row(
    children: [
      Expanded(
        flex: 3,
        child: Text(text),
      ),
      Expanded(
        flex: 7,
        child: SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            decoration: _buildInputDecoration(),
            onTapOutside: (value) => FocusManager.instance.primaryFocus?.unfocus(),
            textInputAction: TextInputAction.next
          )
        )
      )
    ]
  );
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged onChanged;

  const PasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged
  });

  @override 
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override 
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text("Password"),
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: 40,
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              obscureText: _obscureText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                enabledBorder: _buildTextFieldBorder(),
                focusedBorder: _buildTextFieldBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText 
                    ? Icons.visibility_off 
                    : Icons.visibility
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  }
                )
              ),
              onTapOutside: (value) => FocusManager.instance.primaryFocus?.unfocus(),
              textInputAction: TextInputAction.next
            )
          )
        )
      ]
    );

  } 

}










