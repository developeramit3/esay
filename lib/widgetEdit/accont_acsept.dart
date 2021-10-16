import 'package:flutter/material.dart';
import 'package:esay/widgets/appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  final String text;
  const PrivacyPolicy({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", showBack: true),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment:MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "سياسة الخصوصية",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "المملة",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "بس لازم تكون موجودة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit1)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit0)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit2)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit3)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit4)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit5)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(5),
                      child: Text(edi)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit6)),
                  Container(
                      alignment: Alignment.centerRight, child: Text(tit7)),
                  Container(
                      alignment: Alignment.centerRight, child: Text(tit8)),
                  Container(
                      alignment: Alignment.centerRight, child: Text(tit9)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit11)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit12)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit13)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(titEdit)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(titEdit2)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit14)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit15)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit16)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit17)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit18)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit19)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit20)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit21)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit22)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit23)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit24)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit25)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit26)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit27)),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      child: Text(tit28)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String get edi => '- يقوم تطبيقنا الالكتروني بجمع وحفظ المعلومات التالية عنك وإن لم تقم بالاشتراك/ أو تسجيل الدخول على تطبيقنا:';
String get tit0 =>
    "- نعدك بعدم بيع أو تأجير أو مشاركة معلوماتك الشخصية لأي طرف ثالث (باستثناء ما هو منصوص عليه في سياسة الخصوصية هذه) دون موافقتك. حيث أننا لا نؤجر أو نبيع أو نشارك المعلومات الشخصية الخاصة بك، ولن نكشف عن أي معلومات شخصية إلى أي طرف ثالث إلا في الحالات التالية:";
String get tit =>
    "شكراً لكم لزيارة تطبيقنا الالكتروني والتسجيل فيه، ولكن يرجى قراءة هذه البنود والشروط بعناية حيث أنها تحدد شروط الاستخدام وسياسات الخصوصية التي تخضع لها عند استخدامك للتطبيق كزائر أو كمستخدم مسجل حيث تطبق شروط الاستخدام وسياسات الخصوصية هذه على أي استخدام للتطبيق. وأنك بمجرد دخولك أو استخدامك التطبيق، تكون قد وافقت على شروط الاستخدام وسياسات الخصوصية هذه، وفي حال كنت غير موافق على هذه الشروط فلا يجوز لك استخدام التطبيق.";
String get tit1 =>
    "سياسة الخصوصية هذه توفر طريقة جمع البيانات الخاصة بك بالطريقة المستخدمة من قبل تطبيقنا الإلكتروني وننصح بقراءة سياسة الخصوصية بعناية. أنت توافق على جمع واستخدام البيانات الخاصة بك عن طريق التطبيق الالكتروني بالطريقة المنصوص عليها في سياسة الخصوصية هذه. نقدر ثقتك بنا، ونريدك أن تشعر بالراحة والأمان عند استخدام تطبيقنا ومشاركتك المعلومات الخاصة بك معنا، وبالتالي نحن فخورون للغاية بالتزامنا لحماية خصوصيتك. نرجو مواصلة قراءة السياسة التالية لفهم كيف يتم التعامل مع المعلومات الشخصية الخاصة بك.";
String get tit2 => "1- أن يكون لدينا إذن منك.";
String get tit3 =>
    '2- للمساعدة في تحقيق أو منع التصرفات التي تتعلق بأنشطة غير مشروعة وغير قانونية أو المشتبه بهم بالاحتيال أو التي تشكل خطراً على سلامة أو أمن أي شخص أو في حالات انتهاك "اتفاقية الاستخدام" أو للدفاع ضد المطالبات القانونية.';
String get tit4 =>
    "3- حالات الظروف خاصة مثل الامتثال لأوامر المحكمة، طلب/أمر من السلطة النظامية.";
String get tit5 =>
    '- يجمع التطبيق الالكتروني المعلومات التي قدمت من خلالكم عند الاشتراك/ أو التسجيل في التطبيق الإلكتروني وجمع المعلومات عن العمليات التي تقوم بها على التطبيق الالكتروني، ونحن نراقب أيضاً أنماط حركة المرور للمشتركين/أو المستخدمين واستخدام "التطبيق"، والتي تمكننا من تحسين الخدمة التي نقدمها.';
String get tit6 => '1- الدولة التي يتم استخدام التطبيق الالكتروني منها.';
String get tit7 => '2- نظام تشغيل المستخدم.';
String get tit8 => '3- الرقم التعريفي للجهاز "device id".';
String get tit9 => '4- جمع المعلومات الإحصائية والتطويرية.';
String get tit11 =>
    '- يمكنك إنهاء حسابك في أي وقت، ومع ذلك قد تبقى معلوماتك المحفوظة في الأرشيف على خوادمنا حتى بعد حذف أو إنهاء حسابك.';
String get tit12 =>
    '- رغم أننا سوف نعمل على الحفاظ على سرية معلوماتك الشخصية، إلا أنه لا يمكن أن يكون الإرسال الذي يتم بواسطة شبكة الإنترنت آمن تماماً. باستخدام هذا التطبيق الالكتروني، فإنك توافق على أننا لا نتحمل أية مسؤولية عن الإفصاح عن المعلومات الخاصة بسبب أمر خارج عن أرادتنا.';
String get tit13 =>
    '- بموافقتك على استخدام التطبيق الالكتروني وخدماتنا الإلكترونية فإنك بذلك توافق أيضا على استقبال تواصلنا الإلكتروني معك بجميع أشكاله من خلال البريد الإلكتروني أو النشرات الدورية أو الإشعارات والتنبيهات المعلن عنها في التطبيق الإلكتروني، بناء على ذلك فأنت توافق ضمنياً على أن جميع المعاملات الإلكترونية المرسلة لك من قبلنا هي ملزمة قانونيا وتعامل معاملة المعاملات الخطية .';
String get tit14 => 'الرسوم والأمان';
String get titEdit =>
    '- أنت توافق بأن تمنحنا حقاً غير محدود باستخدام معلوماتك الشخصية أو غير ذلك، التي زودتنا بها من خلال الاشتراك والتسجيل في التطبيق الإلكتروني، وذلك عبر النماذج المخصصة للتواصل والتسجيل، أو عبر أية رسالة إلكترونية أو أي من قنوات الاتصال المتاحة بـالتطبيق الالكتروني بهدف تشغيل وترويج "التطبيق" وذلك وفقا لسياسة الخصوصية الخاصة بنا.';
String get titEdit2 =>
    'الفيروسات والاعتداءات الضارة الأخرى على التطبيق الالكتروني يجب عليك عدم إساءة استخدام التطبيق الالكتروني من خلال إدخال فيروسات أو مواد خبيثة أو ضارة أخرى عن عمد. ويجب عليك عدم محاولة الدخول غير المصرح به إلى تطبيقنا. يجب عليك عدم مهاجمة تطبيقنا من خلال أو عن طريق القيام بهجمات "حجب الخدمة". سنقوم بالإبلاغ عن مثل هذه الأعمال إلى السلطات وسنكشف عن هويتك لهم.لن نكون مسؤولين عن أي فقد أو ضرر ناجم عن هجمات الحرمان من الخدمة أو فيروسات أو أي مواد ضارة أخرى والتي قد تؤثر على الأجهزة المحمولة الخاصة بك أو البرمجيات أو البيانات أو مواد أخرى خاصة بك نتيجة لاستخدامك لتطبيقنا.';

String get tit15 =>
    'إنك تقر بتحملك المسئولية منفرداً عن خصوصية المعلومات القانونية المعروضة في حسابك على تطبيقنا الالكتروني، وتكون مسؤولاً منفرداً عن استخدامها من قبل أي شخص آخر باستخدام حسابك و/أو اسم المستخدم أو كلمة المرور أو مسوغات الوصول الخاصة بك. كما أنك توافق على إخطارنا إذا حصل أي سرقة، أو استخدام غير مصرح به لأي كلمة مرور، أو اسم مستخدم أو عنوان بروتكول الانترنت IP، أو غير ذلك من أساليب الوصول إلى التطبيق الالكتروني.عند انتهاء صلاحية الاشتراك فإننا نقوم تلقائياً بحجب الخدمة عنك حتى يتم تجديد الاشتراك ودفع المستحقات ليتم بعد ذلك تفعيل حسابك. ويتم تحديد مقدار رسوم الاشتراك وكيفية دفعها من قبلنا ونقوم بإعلامك بها عند رغبتك بالاشتراك.يحق لنا في أي وقت إيقاف الخدمات المقدمة مجاناً للمشتركين/ أو المستخدمين في أي وقت من الأوقات ودون إنذار أو إشعار مسبق.';
String get tit16 => 'التعويض';
String get tit17 =>
    'إنك توافق على تعويضنا عن أي مطالبات وتكاليف وأضرار وخسائر ومسؤوليات ومصروفات (بما في ذلك أتعاب وتكاليف المحاماة) تنشأ عن أو ترتبط بما يلي:- استخدامك للتطبيق الإلكتروني بصورة تنتهك شروط الاستخدام وسياسات الخصوصية.- أي مطالبة بالتعويض عن التعدي على حقوق الملكية الفكرية وحقوق الطبع والنشر.';
String get tit18 => '- إساءة استخدامك للتطبيق الالكتروني.';
String get tit19 => 'إخلاء المسؤولية وحدود المسائلة القانونية';
String get tit20 =>
    'على الرغم من أننا نسعى لضمان أن تكون العروض والمزايا المقدمة عن طريق التطبيق الالكتروني صحيحة ودقيقة وحديثة، لكننا لا نضمن أن تكون صحيحة 100% بشكل دائم. ونظراً لطبيعة الإنترنت، فإننا لا يمكننا أن نضمن خلو التطبيق الإلكتروني من التأخيرات والتوقف والأخطاء. ولا نتحمل مسؤولية أي فقد أو ضرر مباشر أو غير مباشر أو تبعي أو فقدان للمعلومات المحفوظة في حسابك الخاص.أن استخدام هذا التطبيق الإلكتروني يكون على مسؤوليتك الشخصية، حيث أنك تتحمل جميع المخاطر المترتبة على ذلك مع اخلاء مسؤوليتنا عن تحمل أية مسؤولية عن أي ضرر مباشر أو غير مباشر مادي أو معنوي يلحق بك وينشأ عن استخدام هذا التطبيق الالكتروني أو من عدم التمكن من استخدامه أو خطأ يوجد فيه أو من أي نتائج مترتبة على هذا الضرر.';
String get tit21 => 'التنازلات';
String get tit22 =>
    'إذا قمت بانتهاك شروط الاستخدام وسياسات الخصوصية هذه ولم نتخذ أي إجراء بحقك، فما زال من حقنا استخدام حقوقنا والانتصاف في أي حالة أخرى عند انتهاك شروط الاستخدام وسياسات الخصوصية هذه';
String get tit23 => 'قابلية الفصل';
String get tit24 =>
    'إذا تم اعتبار أي شرط من شروط الاستخدام وسياسات الخصوصية هذه باطل أو غير صالح أو غير قابل للتنفيذ، سيتم إعتبار هذا الشرط منفصل ولن يؤثر على صحة أو نفاذ أي من الشروط الأخرى';
String get tit25 => 'القانون واجب التطبيق';
String get tit26 =>
    'تخضع شروط المستخدم الماثلة ويطبق على تسوية أي نزاع أو مطالبة أو خلاف ينشأ عن شروط المستخدم الماثلة أو يتعلق بها أو أي انتهاك لها أو إنهائها أو تنفيذها أو تفسيرها أو صحتها أو استخدام الموقع أو الخدمة أو المنصة، للقوانين والأنظمة المطبقة في فلسطين وتفسر وفقا لها ويكون الإختصاص المكاني لمحكمة بداية نابلس';
String get tit27 => 'الاتصال بنا';
String get tit28 =>
    'شكرا لكم لزيارة تطبيقنا الالكتروني وإذا كانت لديك أي مشاكل تقنية أوتعليقات أو اقتراحات، فيسعدنا استقبالها على البريد الالكتروني easyapp@pm.me، حيث أننا نلتزم بتقديم الدعم الفني لمشتركينا فيما يتعلق بكيفية عمل التطبيق الإلكتروني والاستفادة منه.';
