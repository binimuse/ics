class Updaterating {
  static String update(String id, int rating) {
    return '''
mutation {
  update_ics_service_complaints_by_pk(_set: {rating: "$rating"}, pk_columns: {id: "$id"}) {
   id
  }
}

    ''';
  }
}
