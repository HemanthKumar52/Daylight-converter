import 'package:uuid/uuid.dart';

class AvailableTimeZone {
  static const String _newyork = 'America/New_York';
  static const String _losangeles = 'America/Los_Angeles';
  static const String _kolkata = 'Asia/Kolkata';

  final String id;
  final String identifier;
  final String cityName;
  final String abbreviation;

  const AvailableTimeZone({
    required this.id,
    required this.identifier,
    required this.cityName,
    required this.abbreviation,
  });

  factory AvailableTimeZone.create({
    required String identifier,
    required String cityName,
    required String abbreviation,
  }) => AvailableTimeZone(
    id: Uuid().v4(),
    identifier: identifier,
    cityName: cityName,
    abbreviation: abbreviation,
  );

  static const List<AvailableTimeZone> all = [
        // AFRICA
        AvailableTimeZone(id: '1', identifier: "Africa/Cairo", cityName: "Cairo", abbreviation: "EET"),
        AvailableTimeZone(id: '2', identifier: "Africa/Algiers", cityName: "Algiers", abbreviation: "CET"),
        AvailableTimeZone(id: '3', identifier: "Africa/Tunis", cityName: "Tunis", abbreviation: "CET"),
        AvailableTimeZone(id: '4', identifier: "Africa/Khartoum", cityName: "Khartoum", abbreviation: "CAT"),
        AvailableTimeZone(id: '5', identifier: "Africa/Johannesburg", cityName: "Johannesburg", abbreviation: "SAST"),
          AvailableTimeZone(id: '6', identifier: "Africa/Lagos", cityName: "Lagos", abbreviation: "WAT"),
          AvailableTimeZone(id: '7', identifier: "Africa/Nairobi", cityName: "Nairobi", abbreviation: "EAT"),
          AvailableTimeZone(id: '8', identifier: "Africa/Casablanca", cityName: "Casablanca", abbreviation: "WET"),
          AvailableTimeZone(id: '9', identifier: "Africa/Accra", cityName: "Accra", abbreviation: "GMT"),
          AvailableTimeZone(id: '10', identifier: "Africa/Bamako", cityName: "Bamako", abbreviation: "GMT"),
          AvailableTimeZone(id: '11', identifier: "Africa/Luanda", cityName: "Luanda", abbreviation: "WAT"),
          AvailableTimeZone(id: '12', identifier: "Africa/Maputo", cityName: "Maputo", abbreviation: "CAT"),
          AvailableTimeZone(id: '13', identifier: "Africa/Gaborone", cityName: "Gaborone", abbreviation: "CAT"),
          AvailableTimeZone(id: '14', identifier: "Africa/Kampala", cityName: "Kampala", abbreviation: "EAT"),
          AvailableTimeZone(id: '15', identifier: "Africa/Dakar", cityName: "Dakar", abbreviation: "GMT"),
          AvailableTimeZone(id: '16', identifier: "Africa/Harare", cityName: "Harare", abbreviation: "CAT"),
          AvailableTimeZone(id: '17', identifier: "Africa/Windhoek", cityName: "Windhoek", abbreviation: "CAT"),

        // SOUTH AMERICA
          AvailableTimeZone(id: '18', identifier: "America/Sao_Paulo", cityName: "Sao Paulo", abbreviation: "BRT"),
          AvailableTimeZone(id: '19', identifier: "America/Argentina/Buenos_Aires", cityName: "Buenos Aires", abbreviation: "ART"),
          AvailableTimeZone(id: '20', identifier: "America/Santiago", cityName: "Santiago", abbreviation: "CLT"),
          AvailableTimeZone(id: '21', identifier: "America/Lima", cityName: "Lima", abbreviation: "PET"),
          AvailableTimeZone(id: '22', identifier: "America/Bogota", cityName: "Bogota", abbreviation: "COT"),
          AvailableTimeZone(id: '23', identifier: "America/Caracas", cityName: "Caracas", abbreviation: "VET"),
          AvailableTimeZone(id: '24', identifier: "America/Montevideo", cityName: "Montevideo", abbreviation: "UYT"),
          AvailableTimeZone(id: '25', identifier: "America/La_Paz", cityName: "La Paz", abbreviation: "BOT"),
          AvailableTimeZone(id: '26', identifier: "America/Asuncion", cityName: "Asuncion", abbreviation: "PYT"),
          AvailableTimeZone(id: '27', identifier: "America/Guyana", cityName: "Guyana", abbreviation: "GYT"),
          AvailableTimeZone(id: '28', identifier: "America/Cayenne", cityName: "Cayenne", abbreviation: "GFT"),

        // CENTRAL AMERICA / CARIBBEAN
          AvailableTimeZone(id: '29', identifier: "America/Mexico_City", cityName: "Mexico City", abbreviation: "CST"),
          AvailableTimeZone(id: '30', identifier: "America/Panama", cityName: "Panama", abbreviation: "EST"),
          AvailableTimeZone(id: '31', identifier: "America/Costa_Rica", cityName: "Costa Rica", abbreviation: "CST"),
          AvailableTimeZone(id: '32', identifier: "America/Havana", cityName: "Havana", abbreviation: "CST"),
          AvailableTimeZone(id: '33', identifier: "America/Santo_Domingo", cityName: "Santo Domingo", abbreviation: "AST"),
          AvailableTimeZone(id: '34', identifier: "America/Belize", cityName: "Belize", abbreviation: "CST"),
          AvailableTimeZone(id: '35', identifier: "America/Guatemala", cityName: "Guatemala", abbreviation: "CST"),
          AvailableTimeZone(id: '36', identifier: "America/Managua", cityName: "Managua", abbreviation: "CST"),
          AvailableTimeZone(id: '37', identifier: "America/Port_of_Spain", cityName: "Port of Spain", abbreviation: "AST"),
          AvailableTimeZone(id: '38', identifier: "America/Curacao", cityName: "Curacao", abbreviation: "AST"),

        // NORTH AMERICA
          AvailableTimeZone(id: '39', identifier: _newyork, cityName: "New York", abbreviation: "EST"),
          AvailableTimeZone(id: '40', identifier: _newyork, cityName: "Miami", abbreviation: "EST"),
          AvailableTimeZone(id: '41', identifier: _newyork, cityName: "Boston", abbreviation: "EST"),
          AvailableTimeZone(id: '42', identifier: "America/Chicago", cityName: "Chicago", abbreviation: "CST"),
          AvailableTimeZone(id: '43', identifier: "America/Chicago", cityName: "Houston", abbreviation: "CST"),
          AvailableTimeZone(id: '44', identifier: "America/Denver", cityName: "Denver", abbreviation: "MST"),
          AvailableTimeZone(id: '45', identifier: "America/Phoenix", cityName: "Phoenix", abbreviation: "MST"),
          AvailableTimeZone(id: '46', identifier: _losangeles, cityName: "Los Angeles", abbreviation: "PST"),
          AvailableTimeZone(id: '47', identifier: _losangeles, cityName: "San Francisco", abbreviation: "PST"),
          AvailableTimeZone(id: '48', identifier: _losangeles, cityName: "Seattle", abbreviation: "PST"),
          AvailableTimeZone(id: '49', identifier: "Pacific/Honolulu", cityName: "Honolulu", abbreviation: "HST"),
          AvailableTimeZone(id: '50', identifier: "America/Toronto", cityName: "Toronto", abbreviation: "EST"),
          AvailableTimeZone(id: '51', identifier: "America/Vancouver", cityName: "Vancouver", abbreviation: "PST"),
          AvailableTimeZone(id: '52', identifier: "America/Anchorage", cityName: "Anchorage", abbreviation: "AKST"),
          AvailableTimeZone(id: '53', identifier: "America/Whitehorse", cityName: "Whitehorse", abbreviation: "MST"),
          AvailableTimeZone(id: '54', identifier: "America/St_Johns", cityName: "St. John's", abbreviation: "NST"),

        // EUROPE
          AvailableTimeZone(id: '55', identifier: "Europe/London", cityName: "London", abbreviation: "GMT"),
          AvailableTimeZone(id: '56', identifier: "Europe/Paris", cityName: "Paris", abbreviation: "CET"),
          AvailableTimeZone(id: '57', identifier: "Europe/Berlin", cityName: "Berlin", abbreviation: "CET"),
          AvailableTimeZone(id: '58', identifier: "Europe/Zurich", cityName: "Zürich", abbreviation: "CET"),
          AvailableTimeZone(id: '59', identifier: "Europe/Madrid", cityName: "Madrid", abbreviation: "CET"),
          AvailableTimeZone(id: '60', identifier: "Europe/Rome", cityName: "Rome", abbreviation: "CET"),
          AvailableTimeZone(id: '61', identifier: "Europe/Amsterdam", cityName: "Amsterdam", abbreviation: "CET"),
          AvailableTimeZone(id: '62', identifier: "Europe/Stockholm", cityName: "Stockholm", abbreviation: "CET"),
          AvailableTimeZone(id: '63', identifier: "Europe/Athens", cityName: "Athens", abbreviation: "EET"),
          AvailableTimeZone(id: '64', identifier: "Europe/Warsaw", cityName: "Warsaw", abbreviation: "CET"),
          AvailableTimeZone(id: '65', identifier: "Europe/Prague", cityName: "Prague", abbreviation: "CET"),
          AvailableTimeZone(id: '66', identifier: "Europe/Budapest", cityName: "Budapest", abbreviation: "CET"),
          AvailableTimeZone(id: '67', identifier: "Europe/Helsinki", cityName: "Helsinki", abbreviation: "EET"),
          AvailableTimeZone(id: '68', identifier: "Europe/Dublin", cityName: "Dublin", abbreviation: "IST"),
          AvailableTimeZone(id: '69', identifier: "Europe/Lisbon", cityName: "Lisbon", abbreviation: "WET"),
          AvailableTimeZone(id: '70', identifier: "Europe/Moscow", cityName: "Moscow", abbreviation: "MSK"),
          AvailableTimeZone(id: '71', identifier: "Europe/Istanbul", cityName: "Istanbul", abbreviation: "TRT"),
          AvailableTimeZone(id: '72', identifier: "Europe/Oslo", cityName: "Oslo", abbreviation: "CET"),
          AvailableTimeZone(id: '73', identifier: "Europe/Copenhagen", cityName: "Copenhagen", abbreviation: "CET"),
          AvailableTimeZone(id: '74', identifier: "Europe/Vienna", cityName: "Vienna", abbreviation: "CET"),
          AvailableTimeZone(id: '75', identifier: "Europe/Brussels", cityName: "Brussels", abbreviation: "CET"),
          AvailableTimeZone(id: '76', identifier: "Europe/Sofia", cityName: "Sofia", abbreviation: "EET"),
          AvailableTimeZone(id: '77', identifier: "Europe/Bucharest", cityName: "Bucharest", abbreviation: "EET"),
          AvailableTimeZone(id: '78', identifier: "Europe/Tallinn", cityName: "Tallinn", abbreviation: "EET"),
          AvailableTimeZone(id: '79', identifier: "Europe/Riga", cityName: "Riga", abbreviation: "EET"),
          AvailableTimeZone(id: '80', identifier: "Europe/Vilnius", cityName: "Vilnius", abbreviation: "EET"),

        // ASIA
          AvailableTimeZone(id: '81', identifier: "Asia/Dubai", cityName: "Dubai", abbreviation: "GST"),
          AvailableTimeZone(id: '82', identifier: "Asia/Riyadh", cityName: "Riyadh", abbreviation: "AST"),
          AvailableTimeZone(id: '83', identifier: "Asia/Tehran", cityName: "Tehran", abbreviation: "IRST"),
          AvailableTimeZone(id: '84', identifier: "Asia/Karachi", cityName: "Karachi", abbreviation: "PKT"),
          AvailableTimeZone(id: '85', identifier: "Asia/Tashkent", cityName: "Tashkent", abbreviation: "UZT"),
          AvailableTimeZone(id: '86', identifier: _kolkata, cityName: "Mumbai", abbreviation: "IST"),
          AvailableTimeZone(id: '87', identifier: _kolkata, cityName: "Delhi", abbreviation: "IST"),
          AvailableTimeZone(id: '88', identifier: _kolkata, cityName: "Bangalore", abbreviation: "IST"),
          AvailableTimeZone(id: '89', identifier: _kolkata, cityName: "Chennai", abbreviation: "IST"),
          AvailableTimeZone(id: '90', identifier: "Asia/Colombo", cityName: "Colombo", abbreviation: "IST"),
          AvailableTimeZone(id: '91', identifier: "Asia/Kathmandu", cityName: "Kathmandu", abbreviation: "NPT"),
          AvailableTimeZone(id: '92', identifier: "Asia/Bangkok", cityName: "Bangkok", abbreviation: "ICT"),
          AvailableTimeZone(id: '93', identifier: "Asia/Ho_Chi_Minh", cityName: "Ho Chi Minh City", abbreviation: "ICT"),
          AvailableTimeZone(id: '94', identifier: "Asia/Jakarta", cityName: "Jakarta", abbreviation: "WIB"),
          AvailableTimeZone(id: '95', identifier: "Asia/Singapore", cityName: "Singapore", abbreviation: "SGT"),
          AvailableTimeZone(id: '96', identifier: "Asia/Kuala_Lumpur", cityName: "Kuala Lumpur", abbreviation: "MYT"),
          AvailableTimeZone(id: '97', identifier: "Asia/Manila", cityName: "Manila", abbreviation: "PHT"),
          AvailableTimeZone(id: '98', identifier: "Asia/Taipei", cityName: "Taipei", abbreviation: "CST"),
          AvailableTimeZone(id: '99', identifier: "Asia/Hong_Kong", cityName: "Hong Kong", abbreviation: "HKT"),
          AvailableTimeZone(id: '100', identifier: "Asia/Shanghai", cityName: "Shanghai", abbreviation: "CST"),
          AvailableTimeZone(id: '101', identifier: "Asia/Seoul", cityName: "Seoul", abbreviation: "KST"),
          AvailableTimeZone(id: '102', identifier: "Asia/Tokyo", cityName: "Tokyo", abbreviation: "JST"),
          AvailableTimeZone(id: '103', identifier: "Asia/Baghdad", cityName: "Baghdad", abbreviation: "AST"),
          AvailableTimeZone(id: '104', identifier: "Asia/Damascus", cityName: "Damascus", abbreviation: "EET"),
          AvailableTimeZone(id: '105', identifier: "Asia/Amman", cityName: "Amman", abbreviation: "EET"),
          AvailableTimeZone(id: '106', identifier: "Asia/Baku", cityName: "Baku", abbreviation: "AZT"),
          AvailableTimeZone(id: '107', identifier: "Asia/Yerevan", cityName: "Yerevan", abbreviation: "AMT"),
          AvailableTimeZone(id: '108', identifier: "Asia/Tbilisi", cityName: "Tbilisi", abbreviation: "GET"),
          AvailableTimeZone(id: '109', identifier: "Asia/Ashgabat", cityName: "Ashgabat", abbreviation: "TMT"),
          AvailableTimeZone(id: '110', identifier: "Asia/Dushanbe", cityName: "Dushanbe", abbreviation: "TJT"),
          AvailableTimeZone(id: '111', identifier: "Asia/Phnom_Penh", cityName: "Phnom Penh", abbreviation: "ICT"),
          AvailableTimeZone(id: '112', identifier: "Asia/Vientiane", cityName: "Vientiane", abbreviation: "ICT"),
          AvailableTimeZone(id: '113', identifier: "Asia/Pyongyang", cityName: "Pyongyang", abbreviation: "KST"),

        // OCEANIA / PACIFIC
          AvailableTimeZone(id: '114', identifier: "Australia/Sydney", cityName: "Sydney", abbreviation: "AEST"),
          AvailableTimeZone(id: '115', identifier: "Australia/Melbourne", cityName: "Melbourne", abbreviation: "AEST"),
          AvailableTimeZone(id: '116', identifier: "Pacific/Auckland", cityName: "Auckland", abbreviation: "NZST"),
          AvailableTimeZone(id: '117', identifier: "Pacific/Fiji", cityName: "Fiji", abbreviation: "FJT"),
          AvailableTimeZone(id: '118', identifier: "Pacific/Guam", cityName: "Guam", abbreviation: "ChST"),
          // Pacific/Tahiti often needs context as Pacific/Tahiti or similar, standard is Pacific/Tahiti
          AvailableTimeZone(id: '119', identifier: "Pacific/Tahiti", cityName: "Tahiti", abbreviation: "TAHT"),
          // Samoa can be Pacific/Apia
          AvailableTimeZone(id: '120', identifier: "Pacific/Apia", cityName: "Samoa", abbreviation: "WST"),
          AvailableTimeZone(id: '121', identifier: "Pacific/Tongatapu", cityName: "Tonga", abbreviation: "TOT"),
          AvailableTimeZone(id: '122', identifier: "Australia/Adelaide", cityName: "Adelaide", abbreviation: "ACST"),
          AvailableTimeZone(id: '123', identifier: "Australia/Darwin", cityName: "Darwin", abbreviation: "ACST"),
          AvailableTimeZone(id: '124', identifier: "Pacific/Chatham", cityName: "Chatham", abbreviation: "CHAST"),
          AvailableTimeZone(id: '125', identifier: "Pacific/Nauru", cityName: "Nauru", abbreviation: "NRT"),
          AvailableTimeZone(id: '126', identifier: "Pacific/Niue", cityName: "Niue", abbreviation: "NUT"),
          AvailableTimeZone(id: '127', identifier: "Pacific/Pago_Pago", cityName: "Pago Pago", abbreviation: "SST"),
          AvailableTimeZone(id: '128', identifier: "Pacific/Funafuti", cityName: "Funafuti", abbreviation: "TVT"),

          AvailableTimeZone(id: '129', identifier: "UTC", cityName: "UTC", abbreviation: "UTC"),
  ];
}
