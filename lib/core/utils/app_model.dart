import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/common/category/data/models/category_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/driver/data/models/driver_model.dart';
import 'package:wajed_app/market/market/data/models/market_model.dart';
import 'package:wajed_app/user/home/data/models/field_model.dart';

import '../../common/auth/data/models/user_response.dart';
import '../../common/order/data/models/order_status_model.dart';
import '../../user/cart/data/models/payment_method_model.dart';
import '../constants/layout/palette.dart';

UserResponse? currentUser;

AddressModel? currentDefulteAddress;
List<FieldModel> fields = [];
List<CategoryModel> categories = [];
 Map<int, int> favFound = {};

MarketModel? marketDetails;

DriverModel? driverDetails;
String token = "";

/// * rols

/// * List order status

final List<OrderStatusModel> orderStatus = [
  OrderStatusModel(
    id: 0,
    name: Strings.order,
    color: Colors.orangeAccent,
  ),
  OrderStatusModel(
    id: 1,
    name: Strings.procceing,
    color: Colors.orange,
  ),
  OrderStatusModel(
    id: 2,
    name: Strings.delvary,
    color: Palette.mainColor,
  ),
  OrderStatusModel(
    id: 3,
    name: Strings.complated,
    color: Palette.mainColor,
  ),
  OrderStatusModel(
      id: -1, name: Strings.cancled.tr(), color: Palette.kStoreClosedColor),
];

/// * payment list
List<PaymentMethodModel> payments = [
  PaymentMethodModel(id: 1, name: 'cash'.tr()),
  PaymentMethodModel(id: 2, name: 'visa'.tr()),
  PaymentMethodModel(id: 3, name: 'master'.tr()),
  PaymentMethodModel(id: 4, name: 'apple_pay'.tr()),
  PaymentMethodModel(id: 5, name: 'google_pay'.tr()),
];

final List<String> titlesAppBar = [
  Strings.detailsMarket,
  Strings.store,
  Strings.home,
  Strings.messages,
  Strings.settings,
];

class AppModel {
  static String token = "";
  static String lang = "";
  static String currentRole = "";
  static String arLang = "ar";
  static String engLang = "en";
  static String deviceToken = "";

  static String alertChannelKey = "wajed";
  static String alertChannelName = "wajed";
  static String alertChannelDesc = "notification wajed";


  /// * type notifications
    static const String ordersAlert = "orders";
  static const String actionAlert = "Action";
  static const String chateAlert = "chate";

}

String privacy = """
<div>
 <h1> شروط الاستخدام </h1>
 <p>مقدمه : </p>
 <p> 
 
 </p>


 <h3>المادة الأولى :</h3>
<ol>شروط استعمال منصة ( هاتلي)


  <li>اختيار القسم الصحيح بمنتاجاتك ومراجعته جيداً</li>
  <li>رفع صور جيدة تعكس جودة منتجاتك</li>
  <li> عدم التلاعب بالاسعار مما يضر بالمستهلك والسوق</li>
  <li> عدم نشر المنتجات الممنوعة بنظام المملكه العربية السعودية
( راجع السلع الممنوعه بالأسفل )
</li>
  <li>عدم استعمال منصة هاتلي إذا كنت غير مؤهل شرعاً كالحجر آو الجنون إلى آخره</li>
  <li>٦-عدم تقمص دور منشأة أو جهة بدون علمها والترويج لمنتجاتها على هاتلي</li>
  <li>عدم انتهاك أنظمة حماية البيئة والحياة الفطرية</li>
  <li>عدم استعمال المنصة للعبث أو محاولات السبام أو الطلبات العشوائية أو محاولة الاغراق أو الاختراق إلى آخره.</li>
  <li> غير مسموح قطعاً التواصل مع التجار أو الأشخاص بإسم منصة هاتلي مهما كان السبب و المبرر</li>
  <li> عدم التحايل على العملاء سواء بالأسعار أو المنتجات أو أي طريقة كانت</li>
</ol>



 <h3> البند الثاني</h3>
<ol>السلع الممنوعة في منصة هاتلي


  <li>يمنع الترويج للممنوعات والكحول نهائيا</li>
  <li>منع الترويج لجميع الأجهزة الممنوعة مثل . أجهزة التنصت والتشويش و الليزر وغيرها</li>
<li>يمنع بيع الماركات المقلدة بجميع أنواعها وأشكالها</li>
<li>يمنع بيع وترويج أي مواد مقرصنة وتنتهك الحقوق الفكرية والأدبية وحقوق النسخ</li>
<li>منع الترويج للحيوانات المهددة بالانقراض أو مخالفة نظام الحياة الفطرية
</li>
<li>يمنع الترويج للأسلحة والذخائر وما يدخل في تركيبتها وتصنيعها</li>
<li>يمنع الترويج للأجهزة أو السلع المسروقة</li>
<li>يمنع منعاً باتاً الترويج للأجهزة الحكومية أو الأوسمة والأنواط  أو أي ممتلكات حكومية</li>
<li>منع أي سلعة ممنوعة حسب النظام  في المملكة العربية السعودية</li>

</ol>

 <h3> البند الثالث :</h3>
<ol>
أخلاقيات البيع ( خاصة بالبائع )

  <li>عدم التطفيف في الكيل بالنقص من الوزن مهما كان قليلا</li>
  <li>التعاون مع العميل والصبر عليه والأخذ بالمثل القائل( العميل على حق وأن كان مخطئاً )</li>
<li>أجعل لك سياسية مرنة بالإرجاع والتعاون وأكسب العملاء بحسن تعاونك</li>
<li>لا تتذمر من طلبات العملاء فهذا باب رزق يجب عليك الحمد عليه</li>
<li>اختيار الاسعار المناسبة للبيع وجذب العملاء بها وتذكر أن الكسب السريع لايدوم</li>
<li>إذا كنت تبيع الأكل يجب عليك الاهتمام بالأكل وجودة المواد وتذكر أنه يأكل منه الأطفال والمرضى وكبار السن</li>
<li>إذا كنت تعرض السلع المستعملة يجب عليك شرعا وقانوناً أن تبين مدة أستعمالها ومدى نظافتها وأي ملاحظة على السلعة أن وجدت</li>
<li>عدم زيادة بالسعر لأجل التعويض قيمة التوصيل لأن التوصيل من مهامك ومجاناً مقابل بيع وترويج منتجاتك على نطاق واسع من حولك </li>

</ol>

<hr>
<ol>
أخلاقيات الشراء ( خاصة بالمشتري )


  <li>الشراء والتسوق متعة فلا تعكر مزاجك بأشياء صغيرة مثل تأخير الطلب البسيط أو التغليف إذا كان منتجك بخير</li>
<li>استشعر أن التاجر إنسان ويقع منه الخطأ والنسيان مهما كان حريص يجب تفهم ذلك</li>
<li>تأكد من توفر المال معك قبل اتمام الطلب سواء كاش أو بحسابك البنكي</li>
<li>تقييمك مهم للتاجر يجب مراعاة هذا الأمر بجدية وتذكر أنك محاسب على تقييمك أمام الله</li>
<li>-البيع والشراء من الأمور الجدية بالحياة يجب الابتعاد عن الطلبات الغير جادة التي تضيع وقت وجهد التاجر في تجهيز طلبات وهمية</li>
<li>تذكر أن التاجر يعمل لكسب رزقه وهو موجود على المنصة لخدمتك حاول قدر المستطاع أن تكون له عونا وسندا لتطوير نفسه والكسب الحلال من خلال تكرار الطلب منه وقت حاجتك</li>
</ol>

</div>
 """;
