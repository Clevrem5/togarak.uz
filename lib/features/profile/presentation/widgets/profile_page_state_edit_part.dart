import 'package:togarak/core/exports.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_state_edit_part_button.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_state_edit_part_items.dart';

class ProfilePageStateEditPart extends StatelessWidget {
  const ProfilePageStateEditPart({
    super.key,
    this.email,
    this.name,
    this.surname,
    this.birtData,
    this.number,
    this.gender,
    required this.callback,
  });

  final String? email;
  final String? name;
  final String? surname;
  final String? birtData;
  final String? number;
  final String? gender;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.w,
      height: 229.6.h,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 11.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: BoxBorder.all(color: AppColors.storkeColor, width: 1.2.w),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfilePageStateEditPartButton(
            callback: callback,
          ),
          3.4.verticalSpace,
          Row(
            spacing: 4.w,
            children: [
              ProfilePageStateEditPartItems(
                title: "Elektron Pochta",
                text: email == null ? "clevrem@gmail.com" : email!,
              ),
              ProfilePageStateEditPartItems(
                title: "Tug'ilgan sanasi",
                text: birtData == null ? "05.09.2001" : birtData!,
              ),
            ],
          ),
          4.verticalSpace,
          Row(
            spacing: 4.w,
            children: [
              ProfilePageStateEditPartItems(
                title: "Jinsi",
                text: gender == null ? "Erkak" : gender!,
              ),
              ProfilePageStateEditPartItems(
                title: "Ismi",
                text: name == null ? "Bekzod" : name!,
              ),
            ],
          ),
          4.verticalSpace,
          Row(
            spacing: 4.w,
            children: [
              ProfilePageStateEditPartItems(
                title: "Familya",
                text: surname == null ? "Temirbekov" : surname!,
              ),
              ProfilePageStateEditPartItems(
                title: "Telefon raqami",
                text: number == null ? "+998945987905" : number!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
