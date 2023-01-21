import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import '../../../../model/pending_list_model.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/widgets.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class WelcomeLetterScreen extends StatefulWidget {
  final String userName;
  final List<Order> label;
  const WelcomeLetterScreen(
      {Key? key, required this.label, required this.userName})
      : super(key: key);

  @override
  State<WelcomeLetterScreen> createState() => _WelcomeLetterScreenState();
}

class _WelcomeLetterScreenState extends State<WelcomeLetterScreen> {
  //
  //
  //
  //
  //
  //  "
  @override
  Widget build(BuildContext context) {
    String name = "Dear ${widget.userName},";
    String titleText1 =
        "We are pleased to have you experience our customized gut detox & healing program.\nOver the next 15 days you will witness first hand how effective 100% natural\nfood & yoga can not just detox, heal & enhance your gut’s immunity but also\nwork as a powerful alternative to the commercialized medical system to improve\nyour gut & gut related issues";

    String titleText2 =
        "This program will not just make you feel better but will also give you a basic\nintroduction on managing your health better with just food & yoga.\nWe hope to see you completely healed & well educated about the role of food &\nyoga in your overall well being at the end of your journey with us.";

    String titleText3 =
        "Wish you a pleasant detox & healing experience\nRegards,";

    String sign = "Gut Wellness Club Team";

    String point = "www.gutwellnessclub.in";

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
                    "Welcome Letter",
                    style: TextStyle(
                        fontFamily: "GothamBold",
                        color: gPrimaryColor,
                        fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PdfPreview(
                build: (format) => _generatePdf(
                    titleText1, titleText2, titleText3, sign, point, name),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Printing.layoutPdf(
                    onLayout: (format) => _generatePdf(
                        titleText1, titleText2, titleText3, sign, point, name));
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
            // Expanded(
            //   child: buildPdfList(widget.label),
            // ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(String titleText1, String titleText2,
      String titleText3, String sign, String point, String name) async {
    final pdf = pw.Document(compress: true);
    final titleFont = await fontFromAssetBundle("assets/font/Charm-Bold.ttf");
    final signFont = await fontFromAssetBundle("assets/font/Amsterdam.otf");
    final pointFont = await fontFromAssetBundle("assets/font/Mirza-Bold.ttf");
    final image =
        await imageFromAssetBundle('assets/images/Gut wellness logo.png');
    pdf.addPage(
      pw.Page(
        // theme: pw.ThemeData(
        //     iconTheme: pw.IconThemeData(
        //   color: const PdfColor.fromInt(0xffFCF6F0),
        // )),
        // pageTheme: pw.PageTheme(buildBackground: (_) {
        //   return pw.Container(
        //     color: const PdfColor.fromInt(0xffFCF6F0),
        //   );
        // }),
        //pageFormat: format,
        clip:true,
        build: (context) {
          return pw.Container(
            // height: double.maxFinite,
            // width: double.maxFinite,
            // color: const PdfColor.fromInt(0xffFCF6F0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.SizedBox(
                    height: 7.h,
                    child: pw.Flexible(
                      child: pw.Image(image),
                    ),
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Text(
                  name,
                  style: pw.TextStyle(
                    font: titleFont,
                    fontSize: 8.sp,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.FittedBox(
                  child: pw.Text(
                    titleText1,
                    style: pw.TextStyle(
                      font: titleFont,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.FittedBox(
                  child: pw.Text(
                    titleText2,
                    style: pw.TextStyle(
                      font: titleFont,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.FittedBox(
                  child: pw.Text(
                    titleText3,
                    style: pw.TextStyle(
                      font: titleFont,
                      fontSize: 7.sp,
                    ),
                  ),
                ),
                pw.FittedBox(
                  child: pw.Text(
                    sign,
                    style: pw.TextStyle(
                      font: signFont,
                      fontSize: 5.sp,
                    ),
                  ),
                ),
                pw.Spacer(),
                pw.Footer(
                  title: pw.Text(
                    point,
                    style: pw.TextStyle(font: pointFont, fontSize: 8.sp),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
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
