import 'package:flutter/material.dart';

// Color
Color hintTextColor = const Color(0xff686777).withOpacity(0.36);
Color whiteColor = const Color(0xffffffff);
Color whiteColor30 = Colors.white30;
Color buttonColor = const Color(0xff2b637b);

// TextField Style
EdgeInsetsGeometry textFieldPadding =
    const EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 8);

BorderRadius textFieldBorderRadiusCircular = BorderRadius.circular(12);

OutlineInputBorder textFieldOutlineInputBorder = OutlineInputBorder(
  borderRadius: textFieldBorderRadiusCircular,
  borderSide: const BorderSide(
    color: Color(0xffe2e3e4),
    width: 0.5,
    style: BorderStyle.none,
  ),
);

TextField textField(
        TextEditingController controller, String hintText, bool obscureText) =>
    TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
        fillColor: whiteColor,
        filled: true,
        focusedBorder: textFieldOutlineInputBorder,
        contentPadding: textFieldPadding,
        border: textFieldOutlineInputBorder,
      ),
    );

// Button Style
BorderRadiusGeometry buttonBorderRadius = BorderRadius.circular(12);
ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: buttonColor,
  shape: RoundedRectangleBorder(
    borderRadius: buttonBorderRadius,
  ),
  minimumSize: const Size(double.infinity, 41),
);

ElevatedButton button(
        BuildContext context, String text, Function() onPressed) =>
    ElevatedButton(
      onPressed: onPressed,
      style: elevatedButtonStyle,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

// AppBar Style
PreferredSizeWidget appBar(BuildContext context, String title) => AppBar(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded,
          color: Color(0xff554af0), size: 20.0),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    foregroundColor: whiteColor,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0.0),
      child: Container(
        color: Colors.grey[300],
        height: 0.5,
      ),
    ));
