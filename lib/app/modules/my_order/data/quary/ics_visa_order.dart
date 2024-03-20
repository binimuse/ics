class GetVisaOrder {
  dynamic fetchData() {
    return """
{
  ics_visa_applications(order_by: {created_at: desc}) {
    id
    application_no
    company_reference_number
    review_status
    created_at
    given_name
    surname
    gender
    nationality {
      id
      name
    }
    birth_country {
      id
      name
    }
    birth_date
    birth_place
    email
    occupation {
      id
      name
    }
    abroad_country {
      id
      name
    }
    city
    street_address
    phone_number
    arrival_date
    departure_country {
      id
      name
    }
    departure_city
    airline
    flight_number
    accommodation_type {
      id
      name
    }
    accommodation_name
    accommodation_city
    accommodation_street_address
    accommodation_telephone
    passport_number
    passport_type {
      id
      name
    }
    passport_issued_date
    passport_expiry_date
    passport_issuing_country {
      id
      name
    }
    passport_issuing_authority
    visa_category_validity_type {
      id
      price
      visa_category {
        id
        name
      }
    }
    visa_application_documents(order_by: {created_at: desc}) {
      document_type {
        id
        name
      }
      files
      review_status
      verifier_note
    }
  }
}



   """;
  }
}
