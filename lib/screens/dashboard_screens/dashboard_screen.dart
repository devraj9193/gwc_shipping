import 'package:flutter/material.dart';
import '../gwc_teams_screens/gwc_teams_screen.dart';
import '../../widgets/will_pop_widget.dart';
import '../profile_screens/profile_screen.dart';
import '../shipment_screens/shipping_status.dart';
import 'bottom_tap_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _bottomNavIndex = 0;

  // void _onItemTapped(int index) {
  //   if (index != 3) {
  //     setState(() {
  //       _bottomNavIndex = index;
  //     });
  //   } else {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => const ProfileScreen()),
  //     );
  //   }
  //   if (index != 2) {
  //     setState(() {
  //       _bottomNavIndex = index;
  //     });
  //   } else {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => const QuriesScreen()),
  //     );
  //   }
  //   if (index != 1) {
  //     setState(() {
  //       _bottomNavIndex = index;
  //     });
  //   } else {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => const CustomerStatusScreen()),
  //     );
  //   }
  // }

  pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return const ShippingStatus();
        }
      case 1:
        {
          return const GwcTeamsScreen();
        }
      case 2:
        {
          return const ProfileScreen();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //
          //   backgroundColor: gWhiteColor,
          //   elevation: 0,
          //   title: Padding(
          //     padding:  EdgeInsets.symmetric(horizontal: 2.w),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         SizedBox(
          //           height: 15.h,
          //           child: const Image(
          //             image: AssetImage("assets/images/Gut wellness logo.png"),
          //           ),
          //         ),
          //         IconButton(
          //           onPressed: () {
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (ct) => const NotificationScreen(),
          //               ),
          //             );
          //           },
          //           icon: Icon(
          //             Icons.notifications_outlined,
          //             color: newBlackColor,
          //             size: 3.h,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          body: pageCaller(_bottomNavIndex),
          bottomNavigationBar: BottomTapBar(
            index: _bottomNavIndex,
            onChangedTab: onChangedTab,
          ),
        ),
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }
}
