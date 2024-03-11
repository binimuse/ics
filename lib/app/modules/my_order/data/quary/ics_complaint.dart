class GetIcsComplaint {
  dynamic fetchData() {
    return """
{
  ics_service_complaints(order_by: {created_at: desc}) {
    id
    created_at
    complaint_type {
      id
      name
      complaint_service {
        id
        name
      }
    }
    embassy {
      id
      name
    }
    files
    message
    rating
    resolved
    resolved_at
    resolver_note
  }
}



   """;
  }
}
