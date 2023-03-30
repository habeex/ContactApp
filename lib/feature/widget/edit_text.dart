import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditText extends StatefulWidget {
  final TextStyle? labelStyle;
  final String hintText;
  final String labelText;
  final TextStyle? hintStyle;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final Color? fillColor;
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  final FloatingLabelBehavior floatingLabelBehavior;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final int? maxlength;
  String? infoText;

  EditText({
    Key? key,
    this.initialValue,
    this.hintText = '',
    this.labelText = '',
    this.hintStyle,
    this.errorText,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.focusNode,
    this.validator,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.contentPadding,
    this.maxlength,
    this.readOnly = false,
    this.enabled = true,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.labelStyle,
    this.textInputAction,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization,
    this.autovalidateMode,
    this.fillColor,
    this.infoText,
  }) : super(key: key);
  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    Color grey = Colors.grey;
    Color blue = Colors.blue;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: widget.labelStyle ??
              TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.controller,
          onTap: widget.onTap,
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxlength,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            floatingLabelBehavior: widget.floatingLabelBehavior,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            fillColor: widget.fillColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: grey.withOpacity(.7), width: 1),
                borderRadius: BorderRadius.circular(4)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: grey.withOpacity(.7), width: 1),
                borderRadius: BorderRadius.circular(4)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blue, width: 1),
                borderRadius: BorderRadius.circular(4)),
            hintText: widget.hintText,
            // label: Text(widget.hintText),
            hintStyle: TextStyle(fontWeight: FontWeight.w400, color: grey),
            labelStyle: TextStyle(fontWeight: FontWeight.w400, color: blue),
          ),
        ),
      ],
    );
  }
}
