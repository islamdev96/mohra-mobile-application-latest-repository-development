import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/personality/presentation/screen/check_personality_screen_content.dart';
import 'package:starter_application/features/personality/presentation/state_m/provider/check_personality_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';
import 'dart:ui' as ui;
class TermsandConditionsScreen extends StatefulWidget {
  static const routeName = "/TermsandConditionsScreen";
  TermsandConditionsScreen({Key? key}) : super(key: key);

  @override
  _TermsandConditionsScreenState createState() => _TermsandConditionsScreenState();
}

class _TermsandConditionsScreenState extends State<TermsandConditionsScreen> {

  String ar='''

التزام المشاركة:
أقر بأنني قد قرأت وفهمت جميع الشروط والأحكام المذكورة في هذا الوثيقة، وأوافق على الامتثال لها خلال مشاركتي في الفعاليات المنظمة. أدرك أن عدم الامتثال لهذه الشروط والأحكام قد يؤدي إلى إلغاء مشاركتي في الفعالية.

المسؤولية:
أتحمل كامل المسؤولية عن أي أضرار مادية أو بدنية أو أية خسائر تنشأ عن مشاركتي في الفعاليات. أقر بأن المنظمين والمسؤولين عن الفعاليات غير مسؤولين عن أية إصابة أو أضرار تلحق بي أو بممتلكاتي أثناء المشاركة في الفعالية.

الملكية الفكرية:
أؤكد أنني أمتلك جميع الحقوق اللازمة والمرخصة لأي محتوى يتم استخدامه أو عرضه أو نشره خلال مشاركتي في الفعاليات. أوافق على أن المنظمين والمسؤولين عن الفعاليات لديهم الحق في استخدام ونسخ وتعديل ونشر أي محتوى قدمته أو تم عرضه أثناء المشاركة في الفعالية.

الحقوق والخصوصية:
أفهم أن أي معلومات شخصية أو بيانات تقدمها ستُحفظ وتُستخدم وفقًا لسياسة الخصوصية الخاصة بالفعاليات. أوافق على استلام المعلومات العامة والتحديثات المتعلقة بالفعاليات عبر البريد الإلكتروني أو وسائل التواصل الاجتماعي المختارة من قبل المنظمين.

إلغاء المشاركة:
أفهم أنه يمكن إلغاء مشاركتي في الفعاليات بواسطة المنظمين في حالة انتهاكي لأي من الشروط والأحكام المذكورة في هذا الوثيقة أو إذا تعذر عليهم استمرار مشاركتي بأسباب خارجة عن إرادتهم.

التعديل والتغيير:
أوافق على أن المنظمين لهم الحق في تعديل أو تغيير الشروط والأحكام للفعاليات في أي وقت يرونه مناسبًا. وسيتم إشعاري بأي تغييرات عن طريق البريد الإلكتروني أو وسائل التواصل الاجتماعي المختارة من قبل المنظمين.

أقر بأنني قد قرأت وفهمت هذه الشروط والأحكام بشكل كامل، وأوافق على الامتثال لها خلال مشاركتي في الفعاليات المنظمة.''';


  String en = '''

Participation Agreement:
I acknowledge that I have read and understood all the terms and conditions stated in this document, and I agree to comply with them during my participation in the organized events. I understand that failure to comply with these terms and conditions may result in the cancellation of my participation in the event.

Liabilities:
I assume full responsibility for any physical or material damages or any losses that may arise from my participation in the events. I acknowledge that the organizers and officials of the events are not liable for any injury or damage incurred by me or my property during my participation in the event.

Intellectual Property:
I confirm that I own all necessary rights and licenses for any content used, displayed, or published during my participation in the events. I agree that the organizers and officials of the events have the right to use, copy, modify, and publish any content I have provided or displayed during the event for promotional purposes.

Rights and Privacy:
I understand that any personal information or data I provide will be stored and used in accordance with the privacy policy of the events. I consent to receive general information and updates related to the events via email or selected social media channels by the organizers.

Withdrawal of Participation:
I understand that my participation in the events may be withdrawn by the organizers in case of any violation of the terms and conditions in this document or if circumstances beyond their control prevent them from continuing my participation.

Modifications and Changes:
I agree that the organizers have the right to modify or change the terms and conditions for the events at any time they deem necessary. I will be notified of any changes via email or selected social media channels by the organizers.

I acknowledge that I have read and fully understood these terms and conditions, and I agree to comply with them during my participation in the organized events.''';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl :ui.TextDirection.ltr ,
      child: Scaffold(
        appBar: buildAppbar(
            actions: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap:(){
                      setState(() {
                        isArabic = false;
                      });
                    },
                    child: Text(
                      "English",
                      style: TextStyle(
                        color: AppColors.mansourBackArrowColor2,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(" | ",style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                  ),),
                  InkWell(
                    onTap:(){
                      setState(() {
                        isArabic = true;
                      });
                    },
                    child: Text(
                      "عربي",
                      style: TextStyle(
                        color: AppColors.mansourBackArrowColor2,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )]
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(isArabic ? "شروط وأحكام المشاركة في الفعاليات":"Terms and Conditions for Event Participation"),
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  isArabic ?ar:en,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.sp,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
