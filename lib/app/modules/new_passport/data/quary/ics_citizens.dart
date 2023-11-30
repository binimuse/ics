class Getaicscitizens {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_citizens(order_by: {created_at: desc}) {
    abroad_address
    abroad_country_id
    abroad_phone_number
    birth_country_id
    birth_place
    created_at
    date_of_birth
    eye_colour
    gender
    hair_colour
    height
    id
    marital_status
    occupation
    skin_colour
    updated_at
    updated_by_id
    first_name
    father_name
    father_name_json
    first_name_json
    grand_father_name_json
  }
}

   """;
  }
}
