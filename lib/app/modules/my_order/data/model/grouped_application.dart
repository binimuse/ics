import 'package:ics/app/modules/my_order/data/model/ics_visa_application.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';

class GroupedAppliaction {
  CurrentCountry documentType;
  List<ApplicationDocument> document;

  GroupedAppliaction({
    required this.documentType,
    required this.document,
  });
}

class GroupedAppliactionVisa {
  CurrentCountry documentType;
  List<VisaApplicationDocument> document;

  GroupedAppliactionVisa({
    required this.documentType,
    required this.document,
  });
}
