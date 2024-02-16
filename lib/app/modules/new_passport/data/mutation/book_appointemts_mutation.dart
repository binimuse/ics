class NewAppointments {
  static const String newApp = r'''
mutation ($objects: [ics_new_passport_application_appointments_insert_input!]!) {
  insert_ics_new_passport_application_appointments(objects: $objects) {
    returning {
      id
    }
  }
}


  ''';
}
