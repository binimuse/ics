class IcscitizensMutation {
  static const String ics_citizens = r'''
    mutation($objects: [ics_citizens_insert_input]!) {
      insert_ics_citizens(objects: $objects) {
         returning {
      id
    }
      }
    }
  ''';
}
