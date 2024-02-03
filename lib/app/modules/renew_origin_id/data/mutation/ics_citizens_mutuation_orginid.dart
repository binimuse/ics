class IcscitizensMutationReNewOrginId {
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

class IcsReNewOrginIdmutation {
  static const String ics_citizens_reneworginId = r'''
    mutation($objects: [ics_renewal_origin_id_applications_insert_input!]!) {
      insert_ics_renewal_origin_id_applications(objects: $objects) {
         returning {
                citizen_id
    
    }
       
      }
    }
  ''';
}

class ReNewDocApplicationsOrginId {
  static const String newDoc = r'''
    mutation($objects: [ics_renew_origin_id_documents_insert_input!]!) {
      insert_ics_renew_origin_id_documents(objects: $objects) {
         returning {
            id
      
    }
      }
    }
  ''';
}

class DeleteDocApplicationsReNewOrginId {
  static String deleteDoc(String documentTypeId) {
    return '''
      mutation MyMutation {
        delete_ics_renew_origin_id_documents(where: {document_type_id: {_eq: "$documentTypeId"}}) {
          returning {
            id
          }
        }
      }
    ''';
  }
}
