import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class AdvancedAppTextField extends StatefulWidget {
  const AdvancedAppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.errorText = "Maydon to‘ldirilishi shart!!!",
    this.isPassword = false,
    this.isPhone = false,
    this.isDatePicker = false,
    this.keyboardType,
    this.obscureText,
    this.maxLines = 1,
    this.minLines,
    this.color = Colors.white,
    this.borderColor = AppColors.storkeColor,
    this.errorColor = AppColors.errorColor,
    this.cursorColor = AppColors.darkColor,
    this.focusBorderColor = AppColors.primaryBlueColor,
    this.contentPadding,
    this.onChanged,
    this.focusNode,
    this.nextFocus,
    this.autocorrect = false,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final String errorText;
  final bool isPassword;
  final bool isPhone;
  final bool isDatePicker;
  final bool autocorrect;
  final bool? obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final Color color;
  final Color borderColor;
  final Color errorColor;
  final Color cursorColor;
  final Color focusBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;

  @override
  State<AdvancedAppTextField> createState() => _AdvancedAppTextFieldState();
}

class _AdvancedAppTextFieldState extends State<AdvancedAppTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText ?? widget.isPassword;
    if (widget.isPhone && widget.controller != null && widget.controller!.text.isEmpty) {
      widget.controller!.text = "+998";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 336.w,
      height: 48.h,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        cursorColor: widget.cursorColor,
        keyboardType:
            widget.keyboardType ??
            (widget.isPhone
                ? TextInputType.phone
                : widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.text),
        obscureText: _obscure,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        minLines: widget.minLines,
        onChanged: widget.onChanged,
        autocorrect: widget.autocorrect,
        initialValue: widget.controller == null ? widget.initialValue : null,
        inputFormatters: widget.inputFormatters ?? (widget.isPhone ? [FilteringTextInputFormatter.digitsOnly] : null),
        readOnly: widget.readOnly || widget.isDatePicker,
        onTap: widget.isDatePicker
            ? () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  initialDate: now,
                );
                if (picked != null && widget.controller != null) {
                  widget.controller!.text = picked.toIso8601String().split("T").first;
                }
                widget.onTap?.call();
              }
            : widget.onTap,
        validator: (value) {
          if (widget.validator != null) return widget.validator!(value);
          if (value == null || value.trim().isEmpty) return widget.errorText;
          return null;
        },
        onFieldSubmitted: (value) {
          widget.onFieldSubmitted?.call(value);
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        mouseCursor: SystemMouseCursors.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.color,
          hintText: widget.hint,
          labelText: widget.label,
          contentPadding: widget.contentPadding ?? EdgeInsets.only(top: 9.h, right: 9.w, bottom: 9.h, left: 12.h),
          hintStyle: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.grey),
          labelStyle: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.grey.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1.2.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              100,
            ),
            borderSide: BorderSide(
              color: widget.focusBorderColor,
              width: 1.2.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: widget.errorColor,
              width: 1.2.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: widget.errorColor,
              width: 1.2.w,
            ),
          ),
          errorStyle: GoogleFonts.manrope(fontSize: 12.sp, color: widget.errorColor),
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 20, color: Colors.black) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
              : (widget.suffixIcon != null ? Icon(widget.suffixIcon, size: 20, color: Colors.black) : null),
        ),
      ),
    );
  }
}
