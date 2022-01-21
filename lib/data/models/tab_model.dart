class TabModel {
  int? id;
  String? label, iconName;

  TabModel({
    this.id,
    this.label,
    this.iconName,
  });
}

final List<TabModel> mockListTabModel = [
  TabModel(id: 1, label: "Beranda", iconName: "home.png",),
  TabModel(id: 2, label: "Jadwal", iconName: "schedule.png",),
];
