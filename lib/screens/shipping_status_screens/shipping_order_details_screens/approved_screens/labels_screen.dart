import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import '../../../../model/pending_list_model.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/widgets.dart';
import 'package:printing/printing.dart';

class LabelsScreen extends StatefulWidget {
  final List<Order> label;
  const LabelsScreen({Key? key, required this.label}) : super(key: key);

  @override
  State<LabelsScreen> createState() => _LabelsScreenState();
}

class _LabelsScreenState extends State<LabelsScreen> {
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
                    "Shipping Label",
                    style: TextStyle(
                        fontFamily: "GothamBold",
                        color: gPrimaryColor,
                        fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            Expanded(
              child: buildPdfList(widget.label),
            ),
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
                    files[index].labelUrl.toString(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  print(files[index].labelUrl.toString());
                  http.Response response = await http.get(
                    Uri.parse(files[index].labelUrl.toString()),
                  );
                  var pdfData = response.bodyBytes;
                  await Printing.layoutPdf(onLayout: (format) async => pdfData);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 2.h),
                  padding: EdgeInsets.symmetric(vertical: 2.h),
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
                        'Print Label',
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
