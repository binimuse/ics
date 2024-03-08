class ComliantMutation {
  static const String ics_citizens = r'''
mutation ($objects: [ics_service_complaints_insert_input!]!) {
  insert_ics_service_complaints(objects: $objects) {
    returning {
      id
    
    }
  }
}

  ''';
}
