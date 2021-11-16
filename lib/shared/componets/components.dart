import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social/shared/styles/icon_broken.dart';

Widget textFormField({
  onFieldSubmitted,
  onTap,
  onChanged,
  validator,
  IconData? suffix,
  IconData? prefix,
  suffixPassword,
  required TextEditingController controller,
  required String label,
  required TextInputType textInputType,
  bool obscureText = false,
}) =>
    TextFormField(
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: textInputType,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: Colors.grey.shade200,
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        //   borderSide: BorderSide(color: Colors.grey, width: 0),
        // ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        //   borderSide: BorderSide(color: Colors.grey, width: 0),
        // ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPassword,
              )
            : null,
        prefixIcon: prefix != null ? Icon(prefix) : null,
        label: Text(label),
      ),
    );

Widget editTextFormField({
  required TextEditingController controller,
  String? labelText,
  String? hintText,
  required TextInputType type,
  IconData? prefix,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefix,
            ),
            helperStyle: TextStyle(height: 100),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 0,
              ),
            ),
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[700],
            )));

Widget elevatedItemBuilder({
  onPressed,
  required String text,
  double? width,
  required Color color,
}) =>
    ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          fixedSize: MaterialStateProperty.all<Size?>(Size(width!, 60.0)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 23.0),
        ));

PreferredSizeWidget? defaultAppBar({
  String? text,
  Widget? leading,
  List<Widget>? actions,
  required BuildContext context,
}) =>
    AppBar(
      titleSpacing: 0.0,
      leading: leading == null ? null : leading,
      title: Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0),
        child: Text(
          text!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20.0),
        ),
      ),
      actions: actions,
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

void navigatorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void showToast({required String text, required Color color}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

Widget textBottomItem({
  required onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
