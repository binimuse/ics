class BasePassportRenewalType {
  String id;
  dynamic name;
  dynamic description;
  List<ChildType> childTypes;

  BasePassportRenewalType({
    required this.id,
    required this.name,
    required this.description,
    required this.childTypes,
  });

  factory BasePassportRenewalType.fromJson(Map<String, dynamic> json) {
    var list = json['child_types'] as List;
    List<ChildType> childTypesList =
        list.map((i) => ChildType.fromJson(i)).toList();

    return BasePassportRenewalType(
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
  dynamic name;
  dynamic description;
  String documentCategoryCode;
  List<PassportIdRenewalInstruction> originIdRenewalInstructions;

  ChildType({
    required this.id,
    required this.name,
    required this.description,
    required this.documentCategoryCode,
    required this.originIdRenewalInstructions,
  });

  factory ChildType.fromJson(Map<String, dynamic> json) {
    var list = json['passport_renewal_instructions'] as List;
    List<PassportIdRenewalInstruction> instructionsList =
        list.map((i) => PassportIdRenewalInstruction.fromJson(i)).toList();

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
        'passport_renewal_instructions':
            originIdRenewalInstructions.map((i) => i.toJson()).toList(),
      };
}

class PassportIdRenewalInstruction {
  String id;
  String title;
  String description;

  PassportIdRenewalInstruction({
    required this.id,
    required this.title,
    required this.description,
  });

  factory PassportIdRenewalInstruction.fromJson(Map<String, dynamic> json) {
    return PassportIdRenewalInstruction(
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
