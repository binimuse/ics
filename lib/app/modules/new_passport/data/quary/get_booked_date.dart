class GetBookedDate {
  dynamic fetchData(String embassy_id) {
    return """
query MyQuery2 {
 ics_new_passport_booked_dates(where: {embassy_id: {_eq:"$embassy_id"}}) {
    booking_date
  }
}

   """;
  }
}
