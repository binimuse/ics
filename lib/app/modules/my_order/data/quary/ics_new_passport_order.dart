class GetanewPassportOrder {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_new_applications(order_by: {created_at: desc}, limit: 5) {
    delivery_date
    expiration_date
    issued
    rejected
    rejected_at
    shipped
    shipped_at
    priority
    passport_number
    shipping_remark
    submitted
    updated_at
    shipped_by_id
    updated_by_id
    rejecter_note
    rejected_by_id
    issuer_note
    issued_by_id
    issued_at
    immigration_approver_note
    immigration_approved_by_id
    immigration_approved_at
    immigration_approved
    id
    embassy_id
    embassy_approver_note
    embassy_approved_by_id
    embassy_approved_at
    embassy_approved
    created_by_id
    created_at
    citizen_id
    biometrics_verified
    application_no
  }
}


   """;
  }
}
