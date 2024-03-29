class GetAllresidencyplication {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_residency_applications(order_by: {created_at: desc}, limit: 3) {
    id
    phone_number
    created_at
    review_status
    passport_expiry_date
    gender
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
    abroad_country {
      id
      name
    }
    residency_application_documents {
      files
      document_status
      created_at
      document_type {
        name
        id
      }
      id
    }
    residency_application_urgency_level {
      id
      name
      price
    }
    occupation {
      id
      name
    }
  }
}




   """;
  }
}
