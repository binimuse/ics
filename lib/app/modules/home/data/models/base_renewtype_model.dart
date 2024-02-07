class BaseOriginIdRenewalType {
  String id;
  String name;
  dynamic description;
  List<ChildType> childTypes;

  BaseOriginIdRenewalType({
    required this.id,
    required this.name,
    required this.description,
    required this.childTypes,
  });

  factory BaseOriginIdRenewalType.fromJson(Map<String, dynamic> json) {
    var list = json['child_types'] as List;
    List<ChildType> childTypesList =
        list.map((i) => ChildType.fromJson(i)).toList();

    return BaseOriginIdRenewalType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      childTypes: childTypesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'child_types': childTypes.map((i) => i.toJson()).toList(),
      };
}

class ChildType {
  String id;
  String name;
  dynamic description;
  String documentCategoryCode;
  List<OriginIdRenewalInstruction> originIdRenewalInstructions;

  ChildType({
    required this.id,
    required this.name,
    required this.description,
    required this.documentCategoryCode,
    required this.originIdRenewalInstructions,
  });

  factory ChildType.fromJson(Map<String, dynamic> json) {
    var list = json['origin_id_renewal_instructions'] as List;
    List<OriginIdRenewalInstruction> instructionsList =
        list.map((i) => OriginIdRenewalInstruction.fromJson(i)).toList();

    return ChildType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      documentCategoryCode: json['document_category_code'],
      originIdRenewalInstructions: instructionsList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'document_category_code': documentCategoryCode,
        'origin_id_renewal_instructions':
            originIdRenewalInstructions.map((i) => i.toJson()).toList(),
      };
}

class OriginIdRenewalInstruction {
  String id;
  String title;
  String description;

  OriginIdRenewalInstruction({
    required this.id,
    required this.title,
    required this.description,
  });

  factory OriginIdRenewalInstruction.fromJson(Map<String, dynamic> json) {
    return OriginIdRenewalInstruction(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
