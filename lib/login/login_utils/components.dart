import "package:flutter/material.dart";
import "package:jellywaves/login/login_utils/fields.dart";

Widget buildLoginBox({
  required ValueChanged onChanged,
  required TextEditingController urlController,  
  required FocusNode urlFocusNode,
  required TextEditingController nameController,
  required FocusNode nameFocusNode,
  required TextEditingController passwordController,
  required FocusNode passwordFocusNode
}) {
  return 
    Container(
      height: 200,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xffDDC6A7),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              buildTextField("Server URL", urlController, urlFocusNode, onChanged),
              buildTextField("Username", nameController, nameFocusNode, onChanged),
              PasswordField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                onChanged: onChanged
              )
          ]
        )
      )
    );
}

Widget connectButton({
  required bool enabled,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 20),
    child:  ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffB83A2E),
        disabledBackgroundColor: Color(0xffdd8078),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        "Connect",
        style: TextStyle(
          color: Color(0xffDDC6A7),
          fontSize: 20,
          fontWeight: FontWeight.bold
        )
      )
    )
  );
}
