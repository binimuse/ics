class GetOrginOrder {
  dynamic fetchData() {
    return """
{
  ics_all_origin_id_applications(order_by: {created_at: desc}) {
    new_id
    renewal_id
    created_at
    renew_application {
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
        grand_father_name_json
        birth_country {
          name
        }
      }
    }
    new_application {
      application_no
      created_at
      citizen {
        first_name
        father_name
        grand_father_name
        father_name_json
        first_name_json
        grand_father_name_json
        birth_country {
          name
        }
      }
    }
  }
  ics_all_passport_applications(order_by: {created_at: desc}) {
    new_id
    renew_id
    created_at
    renew_application {
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
        father_name_json
        first_name_json
        grand_father_name_json
        birth_country {
          name
        }
      }
    }
    new_application {
      application_no
      created_at
      citizen {
        first_name
        father_name
        grand_father_name
        father_name_json
        first_name_json
        grand_father_name_json
        birth_country {
          name
        }
      }
    }
  }
}



   """;
  }
}
