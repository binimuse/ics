class IcsNewApplicationModel {
  dynamic deliveryDate;
  dynamic expirationDate;
  dynamic issued;
  dynamic rejected;
  dynamic rejectedAt;
  dynamic shipped;
  dynamic shippedAt;
  int priority;
  String? passportNumber;
  dynamic shippingRemark;
  bool? submitted;
  String updatedAt;
  dynamic shippedById;
  dynamic updatedById;
  dynamic rejecterNote;
  dynamic rejectedById;
  dynamic issuerNote;
  dynamic issuedById;
  dynamic issuedAt;
  dynamic immigrationApproverNote;
  dynamic immigrationApprovedById;
  dynamic immigrationApprovedAt;
  dynamic immigrationApproved;
  String id;
  String embassyId;
  dynamic embassyApproverNote;
  dynamic embassyApprovedById;
  dynamic embassyApprovedAt;
  bool? embassyApproved;
  String? createdById;
  String createdAt;
  String citizenId;
  bool biometricsVerified;
  String applicationNo;

  IcsNewApplicationModel({
    required this.deliveryDate,
    required this.expirationDate,
    required this.issued,
    required this.rejected,
    required this.rejectedAt,
    required this.shipped,
    required this.shippedAt,
    required this.priority,
    required this.passportNumber,
    required this.shippingRemark,
    required this.submitted,
    required this.updatedAt,
    required this.shippedById,
    required this.updatedById,
    required this.rejecterNote,
    required this.rejectedById,
    required this.issuerNote,
    required this.issuedById,
    required this.issuedAt,
    required this.immigrationApproverNote,
    required this.immigrationApprovedById,
    required this.immigrationApprovedAt,
    required this.immigrationApproved,
    required this.id,
    required this.embassyId,
    required this.embassyApproverNote,
    required this.embassyApprovedById,
    required this.embassyApprovedAt,
    required this.embassyApproved,
    required this.createdById,
    required this.createdAt,
    required this.citizenId,
    required this.biometricsVerified,
    required this.applicationNo,
  });

  factory IcsNewApplicationModel.fromJson(Map<String, dynamic> json) {
    return IcsNewApplicationModel(
      deliveryDate: json['delivery_date'],
      expirationDate: json['expiration_date'],
      issued: json['issued'],
      rejected: json['rejected'],
      rejectedAt: json['rejected_at'],
      shipped: json['shipped'],
      shippedAt: json['shipped_at'],
      priority: json['priority'] ?? 0, // Providing a default value of 0 if null
      passportNumber: json['passport_number'],
      shippingRemark: json['shipping_remark'],
      submitted: json['submitted'],
      updatedAt: json['updated_at'],
      shippedById: json['shipped_by_id'],
      updatedById: json['updated_by_id'],
      rejecterNote: json['rejecter_note'],
      rejectedById: json['rejected_by_id'],
      issuerNote: json['issuer_note'],
      issuedById: json['issued_by_id'],
      issuedAt: json['issued_at'],
      immigrationApproverNote: json['immigration_approver_note'],
      immigrationApprovedById: json['immigration_approved_by_id'],
      immigrationApprovedAt: json['immigration_approved_at'],
      immigrationApproved: json['immigration_approved'],
      id: json['id'],
      embassyId: json['embassy_id'],
      embassyApproverNote: json['embassy_approver_note'],
      embassyApprovedById: json['embassy_approved_by_id'],
      embassyApprovedAt: json['embassy_approved_at'],
      embassyApproved: json['embassy_approved'],
      createdById: json['created_by_id'],
      createdAt: json['created_at'],
      citizenId: json['citizen_id'],
      biometricsVerified: json['biometrics_verified'] ??
          false, // Providing a default value of false if null
      applicationNo: json['application_no'],
    );
  }
}
