import '../exports.dart';

class MainBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;

  const MainBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      // height: 80.h,
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: AppColors.greyHintColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.primaryBlueColor,
        unselectedItemColor: AppColors.greyHintColor,
        backgroundColor: Colors.white,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        iconSize: 20,
        showUnselectedLabels: true,
        elevation: 8,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search_sharp),
            label: "To'garaklarim",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Oilam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}