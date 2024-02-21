class IcscitizensMutation {
  static const String ics_citizens = r'''
    mutation($objects: [ics_citizens_insert_input!]!) {
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

class UpdateNewApplication {
  static String update(String applicationId) {
    return '''
mutation MyMutation {
  update_ics_new_applications(where: {id: {_eq: "$applicationId"}}, _set: {submitted: true}) {
    
    returning {
      id
    }
  }
}

    ''';
  }
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

class DeleteDocApplications {
  static String deleteDoc(String documentTypeId) {
    return '''
      mutation MyMutation {
        delete_ics_new_application_documents(where: {document_type_id: {_eq: "$documentTypeId"}}) {
          returning {
            id
          }
        }
      }
    ''';
  }
}
