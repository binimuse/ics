class IcscitizensMutation {
  static const String ics_citizens = r'''
    mutation($objects: [ics_applications_insert_input!]!) {
      insert_ics_applications(objects: $objects) {
         returning {
                id
       
    }
       
      }
    }
  ''';
}

class UpdateNewApplication {
  static String update(String applicationId) {
    return '''
mutation MyMutation {
  update_ics_applications(where: {id: {_eq: "$applicationId"}}, _set: {submitted: true}) {
    
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
    mutation($objects: [ics_application_documents_insert_input!]!) {
      insert_ics_application_documents(objects: $objects) {
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
        delete_ics_application_documents(where: {document_type_id: {_eq: "$documentTypeId"}}) {
          returning {
            id
          }
        }
      }
    ''';
  }
}
