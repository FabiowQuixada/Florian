class DonationFilterFactory {
  static new(
           start_date = "1994-01-01",
           end_date = "1995-01-01"
         ) {
    return {
      start_date,
      end_date
    };
  }

  static invalid() {
    return {
      start_date: "1995-01-01",
      end_date: "1994-01-01"
    };
  }
}

export default DonationFilterFactory;
