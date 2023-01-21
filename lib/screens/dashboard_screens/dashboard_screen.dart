import 'package:flutter/material.dart';
import '../../widgets/will_pop_widget.dart';
import '../gwc_teams_screens/gwc_teams_screen.dart';
import '../shipping_status_screens/shipping_order_details_screens/profile_screens/profile_screen.dart';
import '../shipping_status_screens/shipping_status.dart';
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
