import 'package:togarak/core/exports.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.title,
    this.size = 14,
    this.weight = FontWeight.w400,
    this.color = AppColors.darkColor,
    this.maxLine = 1,
    this.height = 1.4,
    this.textAlign = TextAlign.start,
    this.soft = false,
    this.decor = TextDecoration.none,
    this.isGirloy=false,
  });

  final String title;
  final double size;
  final FontWeight? weight;
  final Color color;
  final int maxLine;
  final double height;
  final TextAlign textAlign;
  final bool soft;
  final bool? isGirloy;
  final TextDecoration decor;

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: soft,
      title,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: isGirloy == false ? GoogleFonts.manrope(
        fontSize: size.sp,
        fontWeight: weight,
        height: height,
        decoration: decor,
        color: color,
      ):TextStyle(
        fontSize: size.sp,
        fontWeight: weight,
        height: height,
        decoration: decor,
        color: color,
        fontFamily: 'Gilroy',
      )
    );
  }
}
