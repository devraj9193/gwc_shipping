import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import '../../shipment_screens/shipment_list_screens/customer_order_products.dart';

class PackedOrderDetails extends StatefulWidget {
  final String userName;
  const PackedOrderDetails({Key? key, required this.userName}) : super(key: key);

  @override
  State<PackedOrderDetails> createState() => _PackedOrderDetailsState();
}

class _PackedOrderDetailsState extends State<PackedOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                child: buildAppBar(() {
                  Navigator.pop(context);
                }),
              ),
              profileTile("Name : ", widget.userName),
              const CustomerOrderProducts(userId: '',),
            ],
          ),
        ),
      ),
    );
  }

  profileTile(String title, String subTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 5.w),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: gBlackColor,
              fontFamily: 'GothamBold',
              fontSize: 9.sp,
            ),
          ),
          Expanded(
            child: Text(
              subTitle,
              style: TextStyle(
                color: gBlackColor,
                fontFamily: 'GothamMedium',
                fontSize: 8.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
