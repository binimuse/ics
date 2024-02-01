class GetaicscitizensOrginId {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_citizens(order_by: {created_at: desc}, limit: 5) {
    abroad_address
    abroad_country_id
    abroad_phone_number
    birth_country_id
    nationality_id
    is_adopted
    birth_place
    created_at
    date_of_birth
    eye_colour
    gender
    hair_colour
    height
    id
    marital_status
    occupation_id
    skin_colour
    first_name
    father_name
    father_name_json
    grand_father_name
    first_name_json
    grand_father_name_json
    new_origin_id_applications {
      current_passport_number
      current_passport_expiry_date
      current_passport_issued_date
      visa_type_id
      visa_number
    }
  }
}

   """;
  }
}
