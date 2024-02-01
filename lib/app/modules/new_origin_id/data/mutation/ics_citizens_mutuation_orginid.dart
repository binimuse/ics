class IcscitizensMutationOrginId {
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

class IcsnewOrginIdmutation {
  static const String ics_citizens_orginId = r'''
    mutation($objects: [ics_new_origin_id_applications_insert_input]!) {
      insert_ics_new_origin_id_applications(objects: $objects) {
         returning {
                citizen_id
    
    }
       
      }
    }
  ''';
}

class NewDocApplicationsOrginId {
  static const String newDoc = r'''
    mutation($objects: [ics_new_origin_id_documents_insert_input!]!) {
      insert_ics_new_origin_id_documents(objects: $objects) {
         returning {
            id
      
    }
      }
    }
  ''';
}

class DeleteDocApplicationsOrginId {
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
