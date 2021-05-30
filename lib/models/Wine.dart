class Wine {
  int id;
  String country;
  String description;
  String designation;
  int points;
  double price;
  String province;
  String region;
  String tasterName;
  String title;
  String variety;

  Wine(id, country, description, designation, points, price, province, region,
      tasterName, title, variety) {
    this.id = id;
    this.country = country;
    this.description = description;
    this.designation = designation;
    this.points = points;
    this.price = price;
    this.province = province;
    this.region = region;
    this.tasterName = tasterName;
    this.title = title;
    this.variety = variety;
  }
}
