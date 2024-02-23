import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';

class GroupedAppliaction {
  CurrentCountry documentType;
  List<ApplicationDocument> document;

  GroupedAppliaction({
    required this.documentType,
    required this.document,
  });
}

class GroupedPassportAppliaction {
  List<IcsApplication> passport;

  GroupedPassportAppliaction({
    required this.passport,
  });
}

class GroupedOriginAppliaction {
  IcsApplication origin;

  GroupedOriginAppliaction({
    required this.origin,
  });
}
