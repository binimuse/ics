class Getaicscitizens {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_applications(order_by: {created_at: desc}, limit: 3) {
    abroad_address
    abroad_country_id
    phone_number
    birth_country_id
    photo
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
      current_country_id
      embassy_id 
    	citizen_families {
      citizen_id
         family_type
      {
        id
        name
      }
      nationality_id
      first_name
      father_name
    }
  }
}




   """;
  }
}
