class BookedDate {
  List<IcsNewPassportBookedDate> icsNewPassportBookedDates;

  BookedDate({
    required this.icsNewPassportBookedDates,
  });

  factory BookedDate.fromMap(Map<String, dynamic> json) => BookedDate(
        icsNewPassportBookedDates: List<IcsNewPassportBookedDate>.from(
            json["ics_application_booked_dates"]
                .map((x) => IcsNewPassportBookedDate.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ics_application_booked_dates":
            List<dynamic>.from(icsNewPassportBookedDates.map((x) => x.toMap())),
      };
}

class IcsNewPassportBookedDate {
  DateTime bookingDate;

  IcsNewPassportBookedDate({
    required this.bookingDate,
  });

  factory IcsNewPassportBookedDate.fromMap(Map<String, dynamic> json) =>
      IcsNewPassportBookedDate(
        bookingDate: DateTime.parse(json["booking_date"]),
      );

  Map<String, dynamic> toMap() => {
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
      };
}
