import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/colors.dart';

class Text1 extends StatelessWidget {
  final double size;
  final Color color;
  final String text;
  final TextAlign align;
  final int maxLines;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  const Text1({
    super.key,
    this.size = 16,
    this.align = TextAlign.start,
    required this.text,
    this.color = Colors.black,
    this.maxLines =
    100, //if there is no space to show the whole text use --> overflow: TextOverflow.ellipsi
    this.fontWeight = FontWeight.w300,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    double adjustedFontSize =
        size / textScaleFactor; //Fixed Size even the system fontSize is changed

    return Text(text,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow
            .ellipsis, // if the text overflows show rest of it as dots
        textScaler: const TextScaler.linear(1.5),
        style: TextStyle(
          fontFamily: 'Cabin',
          color: color,
          // fontStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: adjustedFontSize,
          fontWeight: fontWeight,
          height: 1.2,
          decoration: decoration,
          decorationColor: color,
        ));
  }
}

class Button extends StatelessWidget {
  final double fontSize;
  final Function function;
  final String text;
  final Color textColor;
  final Color? borderColor;
  final Color color;
  final Color iconColor;
  final double height;
  final Widget? icon;

  const Button({
    super.key,
    this.fontSize = 14,
    required this.function,
    this.text = "",
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.color = mainColor1,
    this.height = 48,
    this.borderColor,
    this.icon,
    // this.color2 = const Color(0xFF2E3192),
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double textScale = MediaQuery.of(context).textScaleFactor;

    return Container(
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(1),
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //     offset: const Offset(2, 3), // changes position of shadow
        //   ),
        // ],
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ?? color,
          width: 1.0,
        ),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: icon == null ? 0 : 8),
            icon ?? const SizedBox.shrink(),
            Text1(
              text: text,
              color: textColor,
              size: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final IconData? suffixIcon;
  final IconData? prefuxIcon;
  final Color iconColor;
  final Color textColor;
  final Color labelColor;
  final Color shade;
  final bool readOnly;
  final int maxLines;
  final String msg;
  final TextStyle? labelStyle;
  final TextInputType keyboard;
  final void Function(String)? onFieldSubmitted; // Callback when user submits
  final void Function()?
  onEditingComplete; // Callback when user finishes editing

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.suffixIcon,
    this.textColor = Colors.black,
    this.prefuxIcon,
    this.readOnly = false,
    this.shade = Colors.transparent,
    this.iconColor = Colors.grey,
    this.labelColor = Colors.grey,
    this.maxLines = 1,
    this.msg = 'Required',
    this.keyboard = TextInputType.text,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            fontFamily: 'Cabin',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: textColor),
        maxLines: maxLines,
        readOnly: readOnly,
        keyboardType: keyboard,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: shade,
          suffixIcon: suffixIcon != null
              ? Icon(
            suffixIcon,
            color: iconColor,
            size: 18,
          )
              : null,
          prefixIcon: prefuxIcon != null
              ? Icon(
            prefuxIcon,
            color: iconColor,
            size: 18,
          )
              : null,
          labelStyle: labelStyle ??
              TextStyle(
                  fontFamily: 'Cabin',
                  color: labelColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: mainColor1),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return msg;
          }
          return null;
        },
        onFieldSubmitted: onFieldSubmitted, // Trigger when user submits
        onEditingComplete:
        onEditingComplete, // Trigger when user finishes editing
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  final String labelText;
  final Color textColor;
  final Color labelColor;
  final Color shade;
  final String msg;
  final TextStyle? labelStyle;
  final String? selectedValue;
  final Function(String?) onChanged;

  const DropdownWidget({
    super.key,
    required this.items,
    required this.labelText,
    this.textColor = Colors.black,
    this.shade = Colors.transparent,
    this.labelColor = Colors.grey,
    this.msg = 'Required',
    this.selectedValue,
    required this.onChanged,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      style: TextStyle(
          fontFamily: 'Cabin',
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: shade,
        labelStyle: labelStyle ??
            TextStyle(
                fontFamily: 'Cabin',
                color: labelColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color:  Color(0xFFE8ECF4)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color:  Color(0xFFE8ECF4)),
        ),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          alignment: Alignment.center,
          value: value,
          child: Text1(
            text: value,
            size: 10,
            maxLines: 1,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return msg;
        }
        return null;
      },
    );
  }
}

class CheckboxWidget extends StatefulWidget {
  final bool value;
  final String labelText;
  final Color textColor;
  final Color checkColor;
  final Color checkBackgroundColor;
  final Color labelColor;
  final Color shade;
  final ValueChanged<bool?> onChanged;

  const CheckboxWidget({
    super.key,
    required this.value,
    required this.labelText,
    this.textColor = Colors.black,
    this.shade = Colors.transparent,
    this.labelColor = Colors.grey,
    this.checkColor = mainColor2,
    this.checkBackgroundColor = mainColor1,
    required this.onChanged,
  });

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: widget.shade,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value ?? false;
              });
              widget.onChanged(value);
            },
            activeColor: widget
                .checkBackgroundColor, // Custom checkbox background color when checked
            side: const BorderSide(color: Colors.grey),
            checkColor: widget.checkColor,
          ),
          Text1(
            text: "${widget.labelText}  ",
            color: widget.labelColor,
            size: 10,
          ),
        ],
      ),
    );
  }
}

class PasswordTextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final Color iconColor;
  final IconData? suffixIcon;
  final Color textColor;
  final Color labelColor;
  final Color shade;
  final TextInputType keyboard;

  const PasswordTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.keyboard = TextInputType.text,
    this.iconColor = const Color(0xFFB3B3B3),
    this.labelColor = Colors.grey,
    this.textColor = Colors.black,
    this.shade = Colors.transparent, // default is transparent
  });

  @override
  _PasswordTextFormFieldWidgetState createState() =>
      _PasswordTextFormFieldWidgetState();
}

class _PasswordTextFormFieldWidgetState
    extends State<PasswordTextFormFieldWidget> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
            fontFamily: 'Cabin',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: widget.textColor),
        keyboardType: widget.keyboard,
        obscureText: !passwordVisible,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.shade,
          labelText: widget.labelText,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: widget.iconColor,
          ),
          labelStyle: TextStyle(
              fontFamily: 'Cabin',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: widget.labelColor),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: mainColor1),
          ),
          suffix: GestureDetector(
            onTap: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            child: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: widget.labelColor,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }
}

class CustomSnackbar {
  static void show(BuildContext context, String message,
      {IconData? icon, bool isError = false}) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 25,
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Dismissible(
            key: const ValueKey("dismiss_snackbar"),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              overlayEntry.remove();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: isError
                    ? Colors.red
                    : mainColor2, // Conditionally set color based on isError flag
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    Icon(icon, color: Colors.white, size: 26.sp),
                  if (icon != null) SizedBox(width: 12.w),
                  Expanded(
                    child: Text1(
                      text: message,
                      align: TextAlign.center,
                      size: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Automatically remove after 3 seconds if not swiped
    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

class CustomButton extends StatelessWidget {
  final Function() onPressed; // Function to be called when button is pressed
  final String text; // Text to be displayed on the button
  final Color textColor; // Text color for the button

  const CustomButton({super.key,
    required this.onPressed,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: MaterialButton(
        onPressed: onPressed, // Button's onPressed action
        color: mainColor1,
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 20), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ), // Button color
        child: Text(
          text, // Text displayed on the button
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "cabin", // Text color
            fontSize: 18, // Text font size
          ),
        ),
      ),
    );
  }
}



