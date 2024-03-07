class GetVisaOrder {
  dynamic fetchData() {
    return """
{
  ics_visa_applications(order_by: {created_at: desc}) {
    
    
    id
    created_at
    application_no
    abroad_country {
      id
      name
    }
    accommodation_city
    accommodation_name
    accommodation_street_address
    accommodation_telephone
    accommodation_type {
      id
      name
    }
    airline
    application_no
    arrival_date
    birth_country {
      name
      id
    }
    birth_date
    city
    company_reference_number
    created_by_id
    departure_city
    departure_country {
      id
      name
    }
    departure_country_id
    email
    flight_number
    passport_expiry_date
    passport_issued_date
    passport_issuing_authority
    passport_issuing_country {
      id
      name
    }
    passport_number
    street_address
    
    surname
    visa_category_validity_type {
      id
      visa_category {
        id
        name
      }
      
      visa_validity_type {
        name
        id
      }
      
      
      
    }
  }
}


   """;
  }
}
