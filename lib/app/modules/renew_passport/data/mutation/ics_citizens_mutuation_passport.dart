class IcscitizensMutationReNewPassport {
  static const String ics_citizens = r'''
mutation ($objects: [ics_applications_insert_input!]!) {
  insert_ics_applications(objects: $objects) {
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
