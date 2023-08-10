import 'package:flutter/material.dart';

import '../utils/constants.dart';

const tapSelectedColor = newBlackColor;
const tapUnSelectedColor = lightTextColor;
const tapIndicatorColor = gSecondaryColor;

class LoginScreen {
  TextStyle welcomeText() {
    return TextStyle(
      fontFamily: fontBold,
      color: newBlackColor,
      fontSize: fontSize12,
    );
  }

  TextStyle doctorAppText() {
    return TextStyle(
      fontFamily: fontBook,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle textFieldHeadings() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle hintTextField() {
    return TextStyle(
      fontFamily: fontBook,
      color: mediumTextColor,
      fontSize: fontSize09,
    );
  }

  TextStyle mainTextField() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle buttonText(Color color) {
    return TextStyle(
      fontFamily: fontBold,
      color: color,
      fontSize: fontSize11,
    );
  }
}

class DashBoardScreen {
  TextStyle headingTextField() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle gridTextField() {
    return TextStyle(
      fontFamily: fontMedium,
      color: whiteTextColor,
      fontSize: fontSize09,
    );
  }
}

class TabBarText {
  TextStyle selectedText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize09,
    );
  }

  TextStyle unSelectedText() {
    return TextStyle(
      fontFamily: fontBook,
      color: lightTextColor,
      fontSize: fontSize09,
    );
  }

  TextStyle bottomSheetHeadingText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: gSecondaryColor,
      fontSize: fontSize11,
    );
  }
}

class AllListText {
  TextStyle headingText() {
    return TextStyle(
      height: 1.3,
      fontFamily: fontBold,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle subHeadingText() {
    return TextStyle(
      fontFamily: fontMedium,
      height: 1.3,
      color: newBlackColor,
      fontSize: fontSize08,
    );
  }

  TextStyle notificationSubHeadingText() {
    return TextStyle(
      fontFamily: fontMedium,
      height: 1.5,
      color: newGreyColor,
      fontSize: fontSize09,
    );
  }

  TextStyle notificationOtherText() {
    return TextStyle(
      height: 1.5,
      fontFamily: fontBook,
      color: newLightGreyColor,
      fontSize: fontSize08,
    );
  }

  TextStyle otherText() {
    return TextStyle(
      height: 1.3,
      fontFamily: fontBook,
      color: newBlackColor,
      fontSize: fontSize08,
    );
  }
  TextStyle deliveryDateOtherText() {
    return TextStyle(
      height: 1.3,
      fontFamily: fontBook,
      color: gSecondaryColor,
      fontSize: fontSize08,
    );
  }
  TextStyle deliveryDateText(String status) {
    return TextStyle(
      height: 1.3,
      fontFamily: fontMedium,
      color:status == "shipping_paused" ? gSecondaryColor : status == "shipping_approved" ? Colors.blue : gPrimaryColor,
      fontSize: fontSize08,
    );
  }
}

class ProfileScreenText {
  TextStyle headingText() {
    return TextStyle(
      fontFamily: fontBold,
      color: newBlackColor,
      fontSize: fontSize12,
    );
  }

  TextStyle subHeadingText() {
    return TextStyle(
      fontFamily: fontBook,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle nameText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle otherText() {
    return TextStyle(
      fontFamily: fontBook,
      color: newBlackColor,
      fontSize: fontSize09,
    );
  }
}

class EvaluationText {
  TextStyle headingText() {
    return TextStyle(
      fontFamily: fontMedium,
      height: 1.0,
      color: boldTextColor,
      fontSize: fontSize11,
    );
  }

  TextStyle subHeadingText() {
    return TextStyle(
      height: 1.3,
      fontFamily: fontBook,
      color: newGreyColor,
      fontSize: fontSize09,
    );
  }

  TextStyle questionText() {
    return TextStyle(
      height: 1.5,
      fontSize: fontSize10,
      color: newBlackColor,
      fontFamily: fontMedium,
    );
  }

  TextStyle answerText() {
    return TextStyle(
      fontFamily: fontBook,
      color: newBlackColor,
      fontSize: fontSize08,
      height: 1.3,
    );
  }
}

class BottomSheetTextStyle {
  TextStyle headingText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize11,
    );
  }

  TextStyle subHeadingText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize09,
    );
  }
}

class MealPlan {
  TextStyle headingText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: newBlackColor,
      fontSize: fontSize10,
    );
  }

  TextStyle subHeadingText() {
    return TextStyle(
      height: 1.3,
      fontFamily: fontMedium,
      color: whiteTextColor,
      fontSize: fontSize09,
    );
  }

  TextStyle timeText() {
    return TextStyle(
      fontSize: fontSize08,
      color: newBlackColor,
      fontFamily: fontBold,
    );
  }

  TextStyle mealText() {
    return TextStyle(
      height: 1.5,
      fontFamily: fontBook,
      color: newBlackColor,
      fontSize: fontSize08,
    );
  }
}
