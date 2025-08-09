import 'package:togarak/core/exports.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.icon,
    this.leadIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.radius,
    this.spacing = 8,
    this.borderColor,
    this.borderWidth = 1,
    this.splashColor,
    this.highlightColor,
    this.splashFactory,
  });

  final VoidCallback onPressed;

  /// Text ko‘rsatish uchun (child berilmasa ishlatiladi)
  final String? text;

  /// Custom widget (text o‘rniga)
  final Widget? child;

  /// Tugma oxirida chiqadigan icon (optional)
  final IconData? icon;

  /// Tugma boshida chiqadigan icon yoki svg yoki Icon widget
  final dynamic leadIcon;

  /// Orqa fon rangi
  final Color? backgroundColor;

  /// Matn yoki icon rangi
  final Color? foregroundColor;

  /// O‘lchamlar
  final double? width;
  final double? height;

  /// Tugma radiusi
  final double? radius;

  /// Iconlar orasidagi bo‘shliq
  final double spacing;

  /// Border rangini o‘zgartirish
  final Color? borderColor;

  /// Border qalinligi (default: 1)
  final double borderWidth;

  /// Splash rangini boshqarish
  final Color? splashColor;

  /// Highlight (bosilgan) rang
  final Color? highlightColor;

  /// Splash turini boshqarish (InkRipple, InkSparkle, NoSplash, etc.)
  final InteractiveInkFeatureFactory? splashFactory;

  Widget? _buildLeadIcon(Color color) {
    if (leadIcon == null) return null;

    if (leadIcon is IconData) {
      return Icon(leadIcon as IconData, color: color);
    } else if (leadIcon is Icon) {
      return leadIcon as Icon;
    } else if (leadIcon is String) {
      return SvgPicture.asset(
        leadIcon,
        width: 20.w,
        height: 20.h,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      );
    } else if (leadIcon is Widget) {
      return leadIcon as Widget;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? AppColors.primaryBlueColor;
    final Color fgColor = foregroundColor ?? Colors.white;
    final Color borderCol = borderColor ?? AppColors.storkeColor;

    final Widget? leadingIcon = _buildLeadIcon(fgColor);

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(bgColor),
        foregroundColor: MaterialStateProperty.all(fgColor),
        minimumSize: MaterialStateProperty.all(Size((width ?? 335).w, (height ?? 48).h)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: borderCol, width: borderWidth),
            borderRadius: BorderRadius.circular((radius ?? 100).r),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        splashFactory: splashFactory ?? InkRipple.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return splashColor ?? fgColor.withOpacity(0.1);
          }
          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused)) {
            return highlightColor ?? fgColor.withOpacity(0.05);
          }
          return null;
        }),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon,
            SizedBox(width: spacing.w),
          ],
          child ??
              AppText(
                title: text ?? '',
                size: 16.sp,
                weight: FontWeight.w600,
                color: fgColor,
              ),
          if (icon != null) ...[
            SizedBox(width: spacing.w),
            Icon(icon, color: fgColor),
          ],
        ],
      ),
    );
  }
}
