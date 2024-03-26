class AllResidancyMutation {
  static const String ics_citizens = r'''
mutation ($objects: [ics_residency_applications_insert_input!]!) {
  insert_ics_residency_applications(objects: $objects) {
    returning {
      id
    
    }
  }
}


  ''';
}

class UpdateAllResidency {
  static String update(String applicationId) {
    return '''
mutation MyMutation {
  update_ics_residency_applications(where: {id: {_eq: "$applicationId"}}, _set: {submitted: true}) {
    
    returning {
      id
    }
  }
}

    ''';
  }
}

class ResidancyApplicationsDoc {
  static const String newDoc = r'''
mutation ($objects:  [ics_residency_application_documents_insert_input!]!) {
  insert_ics_residency_application_documents(objects: $objects) {
affected_rows
  }
}
  ''';
}

class DeleteResidancyApplicationsDoc {
  static String deleteDoc(String documentTypeId) {
    return '''
      mutation MyMutation {
        delete_ics_residency_application_documents(where: {document_type_id: {_eq: "$documentTypeId"}}) {
          returning {
            id
          }
        }
      }
    ''';
  }
}
