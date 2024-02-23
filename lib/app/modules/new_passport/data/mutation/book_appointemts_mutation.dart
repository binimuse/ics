class NewAppointments {
  static const String newApp = r'''
mutation ($objects: [ics_application_appointments_insert_input!]!) {
  insert_ics_application_appointments(objects: $objects) {
    returning {
      id
    }
  }
}

  ''';
}
