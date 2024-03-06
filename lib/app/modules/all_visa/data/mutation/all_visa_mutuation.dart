class AllVisaMutation {
  static const String ics_citizens = r'''
mutation ($objects: [ics_visa_applications_insert_input!]!) {
  insert_ics_visa_applications(objects: $objects) {
    returning {
      id
    
    }
  }
}



  ''';
}

class UpdateAllVisa {
  static String update(String applicationId) {
    return '''
mutation MyMutation {
  update_ics_visa_applications(where: {id: {_eq: "$applicationId"}}, _set: {submitted: true}) {
    
    returning {
      id
    }
  }
}

    ''';
  }
}

class VisaApplicationsDoc {
  static const String newDoc = r'''
mutation ($objects:  [ics_visa_application_documents_insert_input!]!) {
  insert_ics_visa_application_documents(objects: $objects) {
affected_rows
  }
}

  ''';
}

class DeleteVisaApplicationsDoc {
  static String deleteDoc(String documentTypeId) {
    return '''
      mutation MyMutation {
        delete_ics_visa_application_documents(where: {document_type_id: {_eq: "$documentTypeId"}}) {
          returning {
            id
          }
        }
      }
    ''';
  }
}
