class ExpertPhotoModel {
  final String key;
  final String mediaUrl;
  final String location;
  final String description;
  final String userId;
  final bool status;
  final bool adminDisableStatus;
  final String disabledDescription;

  ExpertPhotoModel(
      {this.key,
      this.mediaUrl,
      this.location,
      this.description,
      this.userId,
      this.status,
      this.adminDisableStatus,
      this.disabledDescription});

  factory ExpertPhotoModel.fromDoc(dynamic doc) {
    return ExpertPhotoModel(
        key: doc['_key'],
        mediaUrl: doc['mediaUrl'],
        location: doc['location'],
        description: doc['description'],
        userId: doc['userId'],
        status: doc['status'],
        adminDisableStatus: doc['adminDisableStatus'] ?? false,
        disabledDescription: doc['disabledDescription'] ?? '');
  }

  Map toMap(ExpertPhotoModel doc) {
    var data = Map<String, dynamic>();
    data['_key'] = doc.key;
    data['mediaUrl'] = doc.mediaUrl;
    data['location'] = doc.location;
    data['description'] = doc.description;
    data['userId'] = doc.userId;
    data['status'] = doc.status;
    data['adminDisableStatus'] = doc.adminDisableStatus;
    data['disabledDescription'] = doc.disabledDescription;
    return data;
  }
}
