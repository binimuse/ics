class IcsVisaApplicationModel {
  String? id;
  String? abroadCountryId;
  String? phoneNumber;
  String? birthCountryId;
  String? flightNumber;
  String? accommodationName;
  String? nationalityId;
  String? birthPlace;
  AbroadCountry? departureCountry;
  String? createdAt;
  String? gender;
  String? occupationId;
  String? givenName;
  String? surname;
  AbroadCountry? passportType;
  AbroadCountry? nationality;
  String? email;
  String? streetAddress;
  String? city;
  DateTime? birthDate;
  DateTime? arrivalDate;
  String? airline;
  String? accommodationTypeId;
  String? accommodationTelephone;
  String? accommodationStreetAddress;
  String? accommodationCity;
  AbroadCountry? abroadCountry;
  DateTime? passportExpiryDate;
  DateTime? passportIssuedDate;
  String? passportIssuingAuthority;
  String? passportIssuingCountryId;
  String? passportNumber;

  IcsVisaApplicationModel({
    this.id,
    this.abroadCountryId,
    this.phoneNumber,
    this.birthCountryId,
    this.flightNumber,
    this.accommodationName,
    this.nationalityId,
    this.birthPlace,
    this.departureCountry,
    this.createdAt,
    this.gender,
    this.occupationId,
    this.givenName,
    this.surname,
    this.passportType,
    this.nationality,
    this.email,
    this.streetAddress,
    this.city,
    this.birthDate,
    this.arrivalDate,
    this.airline,
    this.accommodationTypeId,
    this.accommodationTelephone,
    this.accommodationStreetAddress,
    this.accommodationCity,
    this.abroadCountry,
    this.passportExpiryDate,
    this.passportIssuedDate,
    this.passportIssuingAuthority,
    this.passportIssuingCountryId,
    this.passportNumber,
  });

  factory IcsVisaApplicationModel.fromMap(Map<String, dynamic> json) =>
      IcsVisaApplicationModel(
        id: json["id"],
        abroadCountryId: json["abroad_country_id"],
        phoneNumber: json["phone_number"],
        birthCountryId: json["birth_country_id"],
        flightNumber: json["flight_number"],
        accommodationName: json["accommodation_name"],
        nationalityId: json["nationality_id"],
        birthPlace: json["birth_place"],
        departureCountry: json["departure_country"] == null
            ? null
            : AbroadCountry.fromMap(json["departure_country"]),
        createdAt: json["created_at"],
        gender: json["gender"],
        occupationId: json["occupation_id"],
        givenName: json["given_name"],
        surname: json["surname"],
        passportType: json["passport_type"] == null
            ? null
            : AbroadCountry.fromMap(json["passport_type"]),
        nationality: json["nationality"] == null
            ? null
            : AbroadCountry.fromMap(json["nationality"]),
        email: json["email"],
        streetAddress: json["street_address"],
        city: json["city"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        arrivalDate: json["arrival_date"] == null
            ? null
            : DateTime.parse(json["arrival_date"]),
        airline: json["airline"],
        accommodationTypeId: json["accommodation_type_id"],
        accommodationTelephone: json["accommodation_telephone"],
        accommodationStreetAddress: json["accommodation_street_address"],
        accommodationCity: json["accommodation_city"],
        abroadCountry: json["abroad_country"] == null
            ? null
            : AbroadCountry.fromMap(json["abroad_country"]),
        passportExpiryDate: json["passport_expiry_date"] == null
            ? null
            : DateTime.parse(json["passport_expiry_date"]),
        passportIssuedDate: json["passport_issued_date"] == null
            ? null
            : DateTime.parse(json["passport_issued_date"]),
        passportIssuingAuthority: json["passport_issuing_authority"],
        passportIssuingCountryId: json["passport_issuing_country_id"],
        passportNumber: json["passport_number"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "abroad_country_id": abroadCountryId,
        "phone_number": phoneNumber,
        "birth_country_id": birthCountryId,
        "flight_number": flightNumber,
        "accommodation_name": accommodationName,
        "nationality_id": nationalityId,
        "birth_place": birthPlace,
        "departure_country": departureCountry?.toMap(),
        "created_at": createdAt,
        "gender": gender,
        "occupation_id": occupationId,
        "given_name": givenName,
        "surname": surname,
        "passport_type": passportType?.toMap(),
        "nationality": nationality?.toMap(),
        "email": email,
        "street_address": streetAddress,
        "city": city,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "arrival_date":
            "${arrivalDate!.year.toString().padLeft(4, '0')}-${arrivalDate!.month.toString().padLeft(2, '0')}-${arrivalDate!.day.toString().padLeft(2, '0')}",
        "airline": airline,
        "accommodation_type_id": accommodationTypeId,
        "accommodation_telephone": accommodationTelephone,
        "accommodation_street_address": accommodationStreetAddress,
        "accommodation_city": accommodationCity,
        "abroad_country": abroadCountry?.toMap(),
        "passport_expiry_date":
            "${passportExpiryDate!.year.toString().padLeft(4, '0')}-${passportExpiryDate!.month.toString().padLeft(2, '0')}-${passportExpiryDate!.day.toString().padLeft(2, '0')}",
        "passport_issued_date":
            "${passportIssuedDate!.year.toString().padLeft(4, '0')}-${passportIssuedDate!.month.toString().padLeft(2, '0')}-${passportIssuedDate!.day.toString().padLeft(2, '0')}",
        "passport_issuing_authority": passportIssuingAuthority,
        "passport_issuing_country_id": passportIssuingCountryId,
        "passport_number": passportNumber,
      };
}

class AbroadCountry {
  String? id;
  String? name;

  AbroadCountry({
    this.id,
    this.name,
  });

  factory AbroadCountry.fromMap(Map<String, dynamic> json) => AbroadCountry(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
