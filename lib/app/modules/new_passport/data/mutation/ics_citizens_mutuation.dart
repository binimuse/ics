class IcscitizensMutation {
  static const String ics_citizens = r'''
    mutation($objects: [ics_citizens_insert_input]!) {
      insert_ics_citizens(objects: $objects) {
         returning {
      id
        new_applications
          {
            id
          }
    }
       
      }
    }
  ''';
}

class NewDocApplications {
  static const String newDoc = r'''
    mutation($objects: [ics_new_application_documents_insert_input!]!) {
      insert_ics_new_application_documents(objects: $objects) {
         returning {
            id
      
    }
      }
    }
  ''';
}
