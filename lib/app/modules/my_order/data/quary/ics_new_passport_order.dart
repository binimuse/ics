class GetOrginOrder {
  dynamic fetchData() {
    return """
{
  ics_all_origin_id_applications(order_by: {created_at: desc}) {
    new_id
    renewal_id
    created_at
    renew_application {
   renew_origin_id_documents { files, id, document_type { name, id } rejected }
      origin_id_renewal_type {
        id
        name
      }
      application_no
      created_at
      citizen {
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
        nationality {
          id
          name
        }
        occupation {
          name
          id
        }
        phone_number
        photo
        skin_colour
      }
      current_country {
        id
        name
      }
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
    new_application {
      application_no
      created_at
      new_origin_id_documents { files id document_type { name id } rejected }
      citizen {
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
        nationality {
          id
          name
        }
        occupation {
          name
          id
        }
        phone_number
        photo
        skin_colour
      }
      current_country {
        id
        name
      }
      current_passport_number
      visa_number
      visa_type {
        name
        id
      }
      current_passport_expiry_date
      current_passport_issued_date
    }
  }
  ics_all_passport_applications(order_by: {created_at: desc}) {
    new_id
    renew_id
    created_at
    renew_application {
      renew_passport_application_documents { files id document_type { name id } rejected }
      
      passport_number
      passport_renewal_type {
        id
        name
      }
      application_no
      created_at
      citizen {
        first_name
        father_name
        grand_father_name
        gender
        father_name_json
        photo
        first_name_json
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
        nationality {
          id
          name
        }
        occupation {
          name
          id
        }
        phone_number
        photo
        skin_colour
      }
      current_country {
        id
        name
      }
    }
    new_application {
      id
      review_status
        appointments {
        date
        start_time
        rescheduled
      }
         new_application_documents(order_by: {created_at: desc}) { review_status files id document_type { name id } rejected }
  
      application_no
      created_at
      citizen {
        first_name
        father_name
        grand_father_name
        father_name_json
        photo
        gender
        first_name_json
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
        nationality {
          id
          name
        }
        occupation {
          name
          id
        }
        phone_number
        photo
        skin_colour
      }
      current_country {
        id
        name
      }
    }
  }
}






   """;
  }
}
