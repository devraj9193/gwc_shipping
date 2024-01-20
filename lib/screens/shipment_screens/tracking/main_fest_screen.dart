import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../model/pending_list_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

class MainFestScreen extends StatefulWidget {
  final List<Order> mainFest;
  const MainFestScreen({Key? key, required this.mainFest}) : super(key: key);

  @override
  State<MainFestScreen> createState() => _MainFestScreenState();
}

class _MainFestScreenState extends State<MainFestScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppBar(() {
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 1.h),
                  Text(
                    "MainFest",
                    style: TextStyle(
                        fontFamily: "GothamBold",
                        color: gBlackColor,
                        fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            Expanded(child: buildPdfList(widget.mainFest)),
          ],
        ),
      ),
    );
  }

  buildPdfList(List<Order> files) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: files.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                child: SizedBox(
                  height: 150.h,
                  child: SfPdfViewer.network(
                    files[index].manifestUrl.toString(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  http.Response response = await http.get(
                    Uri.parse(files[index].manifestUrl.toString()),
                  );
                  var pdfData = response.bodyBytes;
                  await Printing.layoutPdf(onLayout: (format) async => pdfData);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 2.h),
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                    color: gPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: gMainColor, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 3.h,
                        image: const AssetImage(
                            "assets/images/noun-print-1788507.png"),
                        color: gMainColor,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Print',
                        style: TextStyle(
                          fontFamily: "GothamMedium",
                          color: gMainColor,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
