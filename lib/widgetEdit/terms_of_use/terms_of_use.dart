import 'package:flutter/material.dart';
import 'package:esay/widgets/appbar.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", showBack: true),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment:MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "شروط الاستخدام",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              Container(padding: EdgeInsets.all(10), child: Text(tit1)),
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('التعديلات في التطبيق')),
              Container(padding: EdgeInsets.all(10), child: Text(tit2)),
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
                  padding: EdgeInsets.all(10),
                  child: Text(tit6)),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: Text(tit7)),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: Text(tit8)),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: Text(tit9)),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: Text(tit10)),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: Text(tit11)),
            ],
          ),
        ),
      ),
    );
  }
}

String get tit1 =>
    "شكراً لكم لزيارة تطبيقنا الالكتروني والتسجيل فيه، ولكن يرجى قراءة هذه البنود والشروط بعناية حيث أنها تحدد شروط الاستخدام وسياسات الخصوصية التي تخضع لها عند استخدامك للتطبيق كزائر أو كمستخدم مسجل حيث تطبق شروط الاستخدام وسياسات الخصوصية هذه على أي استخدام للتطبيق. وأنك بمجرد دخولك أو استخدامك التطبيق، تكون قد وافقت على شروط الاستخدام وسياسات الخصوصية هذه، وفي حال كنت غير موافق على هذه الشروط فلا يجوز لك استخدام التطبيق.";
String get tit2 =>
    "إننا نحتفظ بحقنا في إجراء التعديلات على التطبيق الإلكتروني لأي سبب من الأسباب وفي أي وقت.";
String get tit3 => "تاريخ النفاذ والتغييرات في هذه الشروط وسياسة الاستخدام";
String get tit4 =>
    "تسري شروط الاستخدام وسياسة الخصوصية هذه اعتباراً من تاريخ نشر هذه الشروط على التطبيق الإلكتروني. ونحتفظ بحق تعديل شروط الاستخدام من وقت لآخر. ولن نخطر زوار التطبيق الإلكتروني أو عملائنا بأية تعديلات من خلال البريد الإلكتروني أو عناوين الاتصال الشخصية الأخرى. حيث يتحمل مستخدم التطبيق الإلكتروني مسؤولية الاطلاع على شروط الاستخدام من وقت لآخر للتأكد من التزامه بها. وتسري التعديلات اعتباراً من تاريخ نشرها على التطبيق الإلكتروني.";
String get tit5 => "أحقية الحصول على الخدمات";
String get tit6 => "انت تقر وتضمن التالي:";
String get tit7 =>
    "-  أنه لم يسبق أن تم تعطيل استخدامك لخدمات التطبيق الإلكتروني أو منعك من استخدامها في أي وقت من الأوقات.- أنك لست منافساً للتطبيق الإلكتروني، كما أنك لا تقدم أي منتج منافس للخدمات المقدمة منا.- أنك تتمتع بكامل القوة والسلطة للتعاقد وأنك بذلك لن تكون منتهكاً لأي قانون أو عقد.";
String get tit8 => "التسجيل";
String get tit9 =>
    "يقتصر الوصول إلى خدمات التطبيق على المستخدمين الذين قاموا بإنشاء حسابات وقاموا بدفع رسوم الاشتراك. ويجب عليك عدم استخدام اي اسم زائف أو انتحال صفة شخص آخر عند التسجيل لاستخدام التطبيق الالكتروني. وإذا كان لديك حساب للاشتراك ينبغي عليك عدم الكشف عنه إلى طرف ثالث أو السماح لطرف ثالث باستخدامه للوصول إلى الخدمات الخاصة بالمشتركين. وقد نرفض أو نزيل أو نوقف اشتراكك في أي وقت اذا اكتشفنا قيامك بذلك. وكذلك يحظر عليك الدخول من أكثر من جهاز إلى تطبيقنا ما لم تكن مشتركاً في الخدمة التي تسمح لك الدخول من أكثر من جهاز وفي حال مخالفة ذلك سيتم مسائلتك قانونيا.";
String get tit10 => "الملكية الفكرية وحقوق الطبع والنشر";
String get tit11 =>
    "يعتبر هذا التطبيق بجميع محتوياته والعلامات التجارية والشعارات وعلامات الخدمة (سواء مسجلة أو غير مسجلة) التي يتم عرضها على التطبيق تتمتع بحقوق حماية الملكية الفكرية، وأن هذه الأعمال محمية بموجب القوانين الدولية. ";
