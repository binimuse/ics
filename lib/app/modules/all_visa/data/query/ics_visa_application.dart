class GetAllVisaAPplication {
  dynamic fetchData() {
    return """
query MyQuery {
  ics_visa_applications(order_by: {created_at: desc}, limit: 3) {
    id
    abroad_country_id
    phone_number
    birth_country_id
    flight_number
    accommodation_name
    nationality_id
    birth_place
    departure_country
    {
      id
      name
    }
    created_at
    gender
    occupation_id
    given_name
    surname
    passport_type
    {
      id
      name
    }
    nationality {
      id
      name
    }
    email
    street_address
    city
    birth_date
    arrival_date
    airline
    accommodation_type_id
    accommodation_telephone
    accommodation_street_address
    accommodation_city
    abroad_country {
      name
      id
    }
    passport_expiry_date
    passport_issued_date
    passport_issuing_authority
    passport_issuing_country_id
    passport_number
  }
}



   """;
  }
}
