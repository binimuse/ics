class IcscitizensMutationReNewPassport {
  static const String ics_citizens = r'''
mutation ($objects: [ics_citizens_insert_input!]!) {
  insert_ics_citizens(objects: $objects) {
    returning {
      id
      renew_passport_applications {
        id
      }
    }
  }
}

  ''';
}

class IcsReNewPassportmutation {
  static const String ics_citizens_reneworginId = r'''
    mutation($objects: [ics_renew_passport_applications_insert_input!]!) {
      insert_ics_renew_passport_applications(objects: $objects) {
         returning {
                citizen_id
    
    }
       
      }
    }
  ''';
}

class ReNewDocApplicationsPassport {
  static const String newDoc = r'''
    mutation($objects: [ics_renew_passport_application_documents_insert_input!]!) {
      insert_ics_renew_passport_application_documents(objects: $objects) {
         returning {
            id
      
    }
      }
    }
  ''';
}

class DeleteDocApplicationsReNewPassport {
  static String deleteDoc(String documentTypeId) {
    return '''
      mutation MyMutation {
        delete_ics_renew_passport_application_documents(where: {document_type_id: {_eq: "$documentTypeId"}}) {
          returning {
            id
          }
        }
      }
    ''';
  }
}
