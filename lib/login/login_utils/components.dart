import "package:flutter/material.dart";
import "package:jellywaves/login/login_utils/fields.dart";

Widget buildLoginBox({
  required ValueChanged onChanged,
  required TextEditingController urlController,  
  required FocusNode urlFocusNode,
  required TextEditingController nameController,
  required FocusNode nameFocusNode,
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
              buildTextField("Username", nameController, nameFocusNode, onChanged)
          ]
        )
      )
    );
}
