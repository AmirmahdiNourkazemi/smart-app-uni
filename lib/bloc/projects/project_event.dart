abstract class ProjectEvent {}

class ProjectStartEvent extends ProjectEvent {}

class ProjectIDStartEvent extends ProjectEvent {
  String uuid;
  ProjectIDStartEvent(this.uuid);
}

class ProjectInversterEvent extends ProjectEvent {
  String uuid;
  int per_page;
  int page;
  ProjectInversterEvent(this.uuid, {this.per_page = 5, this.page = 1});
}

class ProjectWarrantyEvent extends ProjectEvent {}
