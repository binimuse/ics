import 'package:ics/app/modules/new_origin_id/data/model/base_model_orgin.dart';

class BaseDocModel {
  final List<CommonModel> base_document_types;

  BaseDocModel({
    required this.base_document_types,
  });

  factory BaseDocModel.fromJson(Map<String, dynamic> json) {
    return BaseDocModel(
      base_document_types: List.of(json["base_document_types"])
          .map((i) => CommonModel.fromJson(i))
          .toList(),
    );
  }
}
