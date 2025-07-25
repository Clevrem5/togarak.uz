import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:togarak/core/utils/app_colors.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String selectedLang = 'uz';

  final Map<String, String> languages = {
    'uz': 'Oʻzbek',
    'en': 'English',
    'ru': 'Русский',
  };

  final Map<String, String> flags = {
    'uz': 'assets/icons/uzbek.svg',
    'en': 'assets/icons/english.svg',
    'ru': 'assets/icons/russian.svg',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136.w,
      height: 38.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(100.r),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLang,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.darkColor,
          ),
          isExpanded: true,
          items: languages.entries.map((entry) {
            final code = entry.key;
            final label = entry.value;
            return DropdownMenuItem<String>(
              value: code,
              child: Row(
                children: [
                  SvgPicture.asset(
                    flags[code]!,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    label,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedLang = value;
              });
            }
          },
        ),
      ),
    );
  }
}
