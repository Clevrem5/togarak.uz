import 'package:togarak/core/exports.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_image_user_part_button.dart';

class ProfilePageImageUserPart extends StatelessWidget {
  const ProfilePageImageUserPart({
    super.key,
    required this.share,
    required this.delete,
    required this.image,
  });

  final VoidCallback share;
  final VoidCallback delete;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.w,
      height: 104.h,
      padding: EdgeInsetsGeometry.all(11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: BoxBorder.all(color: AppColors.storkeColor, width: 1.2),
        color: Colors.white,
      ),
      child: Row(
        spacing: 11.w,
        children: [
          Image.asset(
            image,
            width: 64.w,
            height: 64.h,
            fit: BoxFit.cover,
          ),
          Column(
            spacing: 8.h,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  ProfilePageImageUserPartButton(
                    callback: share,
                    icon: Icon(
                      Icons.ios_share_outlined,
                      color: AppColors.primaryBlueColor,
                      size: 20,
                    ),
                  ),
                  ProfilePageImageUserPartButton(
                    callback: delete,
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: AppColors.errorColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 236.w,
                height: 33.h,
                child: AppText(
                  title: "2 MB gacha bo‘lgan rasimlar tavsiya etiladi. JPG yoki PNG rasimlarga ruxsat berilgan",
                  size: 11,
                  weight: FontWeight.w400,
                  maxLine: 2,
                  color: AppColors.greyHintColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
