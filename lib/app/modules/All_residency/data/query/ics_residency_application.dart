class GetAllresidencyplication {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_residency_applications(order_by: {created_at: desc}, limit: 3) {
    id
    occupation {
      id
      name
    }
    phone_number
    created_at
    passport_expiry_date
    passport_issued_date
    passport_number
    email_address
    father_name
    first_name
    grand_father_name
    kebele
    local_address
    visa_number
    visa_reference_no
    visa_workpermit_issued_date
    woreda
    zone_subcity
    nationality {
      id
      name
    }
    country {
      id
      name
    }
    embassy {
      id
      name
    }
    residency_type {
      name
    }
    region {
      id
      name
    }
  }
}



   """;
  }
}
