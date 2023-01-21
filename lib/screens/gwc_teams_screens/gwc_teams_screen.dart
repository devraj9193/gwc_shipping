import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/pop_up_menu_widget.dart';

class GwcTeamsScreen extends StatefulWidget {
  const GwcTeamsScreen({Key? key}) : super(key: key);

  @override
  State<GwcTeamsScreen> createState() => _GwcTeamsScreenState();
}

class _GwcTeamsScreenState extends State<GwcTeamsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 1.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                  child: const Image(
                    image:
                        AssetImage("assets/images/Gut wellness logo green.png"),
                  ),
                ),
                TabBar(
                    labelColor: gPrimaryColor,
                    unselectedLabelColor: gTextColor.withOpacity(0.5),
                    unselectedLabelStyle: TextStyle(
                        fontFamily: "GothamBook",
                        color: gPrimaryColor,
                        fontSize: 8.sp),
                    isScrollable: true,
                    indicatorColor: gPrimaryColor,
                    labelPadding:
                        EdgeInsets.only(right: 40.w, top: 1.h, bottom: 1.h),
                    indicatorPadding: EdgeInsets.only(right: 35.w),
                    labelStyle: TextStyle(
                        fontFamily: "GothamMedium",
                        color: gPrimaryColor,
                        fontSize: 8.sp),
                    tabs: const [
                      Text('Doctors'),
                      Text('Success Team'),
                      Text("Admin")
                    ]),
                Expanded(
                  child: TabBarView(children: [

                    buildDoctors(),
                    buildSuccessTeam(),
                    buildTechTeam(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDoctors() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 1.5.h),
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 2.h,
                          backgroundImage:
                              const AssetImage("assets/images/Ellipse 232.png"),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mrs. Lorem ipsum - 24 F",
                                style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: gTextColor,
                                    fontSize: 7.sp),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "09th Sep 2022 / 08:30 PM",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    color: gTextColor,
                                    fontSize: 5.sp),
                              ),
                            ],
                          ),
                        ),
                        const PopUpMenuWidget(),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  buildSuccessTeam() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 1.5.h),
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 2.h,
                          backgroundImage:
                              const AssetImage("assets/images/Ellipse 232.png"),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mrs. Lorem ipsum - 24 F",
                                style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: gTextColor,
                                    fontSize: 7.sp),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "09th Sep 2022 / 08:30 PM",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    color: gTextColor,
                                    fontSize: 5.sp),
                              ),
                            ],
                          ),
                        ),
                        const PopUpMenuWidget(),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  buildTechTeam() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 1.5.h),
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 2.h,
                          backgroundImage:
                              const AssetImage("assets/images/Ellipse 232.png"),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mrs. Lorem ipsum - 24 F",
                                style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: gTextColor,
                                    fontSize: 7.sp),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "09th Sep 2022 / 08:30 PM",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    color: gTextColor,
                                    fontSize: 5.sp),
                              ),
                            ],
                          ),
                        ),
                        const PopUpMenuWidget(),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
