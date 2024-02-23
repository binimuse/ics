class GetOrginOrder {
  dynamic fetchData() {
    return """
{
  ics_applications(order_by: {created_at: desc}) {
    application_type
    new_passport_applications
    {
      created_at
      application_no
    }
    citizen_families {
      family_type {
        name
      }
      first_name
      father_name
      grand_father_name
      nationality_id
    }
    created_at
    first_name
    father_name
    grand_father_name
    father_name_json
    first_name_json
    photo
    gender
    grand_father_name_json
    birth_country {
      name
    }
    date_of_birth
    abroad_address
    birth_place
    eye_colour
    hair_colour
    height
    id
    is_adopted
    marital_status
    review_status
    nationality {
      id
      name
    }
    occupation {
      name
      id
    }
    current_country {
      id
      name
    }
    embassy_id
    phone_number
    photo
    skin_colour
    application_appointments {
      date
      start_time
      rescheduled
    }
    application_documents(order_by: {created_at: desc}) {
      document_status
      document_type {
        name
        id
      }
      files
      rejected
      id
    }
    new_origin_id_applications {
      created_at
      application_no
      application_id
      current_passport_expiry_date
      current_passport_issued_date
      current_passport_number
      et_passport_expiry_date
      visa_number
      signature
      visa_number
      visa_type {
        name
        id
      }
    }
    renew_passport_applications {
      passport_number
      application_no
      correction_type {
        id
        name
      }
      passport_renewal_type {
        id
        name
      }
      id
    }
    renewal_origin_id_applications {
      origin_id_renewal_type
      {
        id
        name
      }
      application_no
      created_at
      current_passport_number
      visa_number
      visa_type {
        name
        id
      }
      current_passport_expiry_date
      current_passport_issued_date
      visa_expiry_date
      visa_issued_date
      origin_id_number
      
    }
  }
}

   """;
  }
}
