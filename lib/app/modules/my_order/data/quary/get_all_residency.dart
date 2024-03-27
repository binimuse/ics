class GetResidencyQuery {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_residency_applications(order_by: {created_at: desc}) {
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
      rejecter_note
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

class GetallQueryInvestemntResidency {
  dynamic fetchData(String type) {
    return """
{
  base_document_types(where: {document_category: {code: {_eq: "$type"}}}) {
    id
    name
    description
  }

}
   """;
  }
}
