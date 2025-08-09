import 'package:togarak/core/exports.dart';

class ProfilePageLogOutAndResetPasswordPart extends StatelessWidget {
  const ProfilePageLogOutAndResetPasswordPart({
    super.key,
    this.lastChanges,
    required this.resetPassword,
    required this.logOut,
  });

  final String? lastChanges;
  final VoidCallback resetPassword;
  final VoidCallback logOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.w,
      height: 145.9.h,
      padding: EdgeInsetsGeometry.all(11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: BoxBorder.all(color: AppColors.storkeColor, width: 1.2.w),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: "Parol va xavfsizlik",
            size: 14,
            height: 1,
            weight: FontWeight.w600,
          ),
          12.verticalSpace,
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 38.h,
              width: double.infinity,
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                border: BoxBorder.all(color: AppColors.storkeColor, width: 1),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 10.w,
                    children: [
                      Icon(
                        Icons.password,
                        color: AppColors.darkColor,
                        size: 12,
                      ),
                      SizedBox(
                        width: 108.w,
                        height: 18.h,
                        child: AppText(
                          title: "Login paroli",
                          size: 12,
                          weight: FontWeight.w500,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 108.w,
                    height: 36.h,
                    child: AppText(
                      title: lastChanges != null
                          ? "So'ngi bor "
                                "$lastChanges"
                          : "So'ngi bor "
                                "20/11/2024",
                      size: 12,
                      soft: true,
                      textAlign: TextAlign.start,
                      height: 1.2,
                      maxLine: 2,
                      weight: FontWeight.w500,
                      color: AppColors.dark2Color,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primaryBlueColor,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
          8.verticalSpace,
          AppElevatedButton(
            onPressed: logOut,
            icon: Icons.logout_rounded,
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            height: 38,
            child: AppText(
              title: "Chiqish",
              color: Colors.red,
              size: 12,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
