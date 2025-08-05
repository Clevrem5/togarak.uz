import 'package:flutter/services.dart';
import 'package:togarak/core/exports.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.inputType = TextInputType.text,
    this.isObscure = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.enableObscureToggleForNumbers = false,
    this.isHintAsteriskRed = false,
    this.addUzbekPrefix = false, // ✅ Yangi parametr
  });

  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final TextInputType inputType;
  final bool isObscure;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final bool enableObscureToggleForNumbers;
  final bool isHintAsteriskRed;
  final bool addUzbekPrefix; // ✅ Yangi parametr

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool _obscureText;
  String? _errorText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure || widget.enableObscureToggleForNumbers;
    _focusNode = FocusNode();

    // ✅ Agar addUzbekPrefix true bo‘lsa, boshlanishiga +998 qo‘shamiz
    if (widget.addUzbekPrefix && !widget.controller.text.startsWith('+998')) {
      widget.controller.text = '+998';
    }

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
        final validator = widget.validator;
        if (validator != null) {
          final result = validator(widget.controller.text);
          setState(() {
            _errorText = result;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildHintOrError() {
    if (_errorText != null) {
      return Text(
        _errorText!,
        style: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
      );
    }

    if (widget.isHintAsteriskRed && widget.hint.trim().endsWith("*")) {
      final text = widget.hint.trim();
      final main = text.substring(0, text.length - 1);
      return RichText(
        text: TextSpan(
          text: main,
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          children: const [
            TextSpan(
              text: "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }

    return Text(
      widget.hint,
      style: GoogleFonts.manrope(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.greyHintColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPhoneField = widget.inputType == TextInputType.phone;

    // ✅ Telefon validator — 9 ta raqam bo‘lishi kerak
    final validator = widget.validator ??
        (isPhoneField && widget.addUzbekPrefix
            ? (value) {
          final cleaned = value?.replaceAll(RegExp(r'\D'), '');
          if (value == null || value.isEmpty || cleaned!.length != 12) {
            return "To‘liq telefon raqam kiriting";
          }
          return null;
        }
            : null);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48.h),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.inputType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,

        // ✅ Yangi formatlash
        inputFormatters: widget.addUzbekPrefix
            ? [PhoneNumberFormatter()] // Custom formatter
            : (isPhoneField ? [FilteringTextInputFormatter.digitsOnly] : []),

        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          color: _errorText != null ? Colors.red : Colors.grey.shade800,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          errorText: null,
          errorStyle: const TextStyle(height: 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _errorText != null ? Colors.red : Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _errorText != null ? Colors.red : AppColors.darkColor.withValues(alpha: 0.2),
              width: 1.3,
            ),
          ),
          prefixIcon: widget.icon != null
              ? Icon(
            widget.icon,
            color: _errorText != null ? Colors.red : AppColors.greyHintColor,
          )
              : null,
          suffixIcon: (widget.isObscure || widget.enableObscureToggleForNumbers)
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: _toggleObscure,
          )
              : null,
          label: _buildHintOrError(),
        ),
        onChanged: (value) {
          widget.onChanged?.call(value);
          if (_errorText != null) {
            setState(() => _errorText = null);
          }
        },
        validator: (value) {
          final result = validator?.call(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_errorText != result) {
              setState(() => _errorText = result);
            }
          });
          return null;
        },
      ),
    );
  }
}


class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text;

    // +998 bilan boshlanmagan bo‘lsa, avtomatik qo‘shamiz
    if (!newText.startsWith('+998')) {
      newText = '+998' + newText.replaceAll(RegExp(r'\D'), '');
    }

    // Faqat raqamlar va +998 boshida bo‘lishi kerak
    String digitsOnly = newText.replaceAll(RegExp(r'\D'), '');

    // +998 ni saqlab qolamiz, faqat 9 ta raqam qoldiramiz
    String result = '+998';

    if (digitsOnly.length > 3) {
      // 3 dan keyingi raqamlar — ya'ni +998 dan keyin keladigan 9 ta raqam
      String phoneDigits = digitsOnly.substring(3);
      if (phoneDigits.length > 9) {
        phoneDigits = phoneDigits.substring(0, 9);
      }
      result += phoneDigits;
    }

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}
