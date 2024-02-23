class GetBookedDate {
  dynamic fetchData(String embassy_id) {
    return """
query MyQuery2 {
 ics_application_booked_dates(where: {embassy_id: {_eq:"$embassy_id"}}) {
    booking_date
  }
}

   """;
  }
}
