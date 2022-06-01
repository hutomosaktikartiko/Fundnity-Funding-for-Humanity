class FilterModel {
  int? id;
  String? filter;

  FilterModel({
    this.filter,
    this.id,
  });
}

final List<FilterModel> mockListFiltersMyCampaign = [
  FilterModel(
    id: 1,
    filter: "All",
  ),
  FilterModel(
    id: 2,
    filter: "Pending",
  ),
  FilterModel(
    id: 3,
    filter: "Active",
  ),
  FilterModel(
    id: 4,
    filter: "Draft",
  ),
  FilterModel(
    id: 5,
    filter: "Inactive",
  ),
  FilterModel(
    id: 6,
    filter: "Complete",
  ),
  FilterModel(
    id: 7,
    filter: "Claimed",
  ),
];

final List<FilterModel> mockListFiltersMyDonation = [
  FilterModel(
    id: 1,
    filter: "All",
  ),
  FilterModel(
    id: 2,
    filter: "Pending",
  ),
  FilterModel(
    id: 3,
    filter: "Success",
  ),
  FilterModel(
    id: 4,
    filter: "Failed",
  ),
  FilterModel(
    id: 5,
    filter: "Completed",
  ),
];