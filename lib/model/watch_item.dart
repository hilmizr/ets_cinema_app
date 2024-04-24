final String tableWatchItem = 'watch_item';

class WatchItemFields {
  static final List<String> values = [
    id,
    title,
    release_date,
    cover_img,
    description,
    time
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String release_date = 'release_date';
  static final String cover_img = 'cover_img';
  static final String description = 'description';
  static final String time = 'time';
}

class WatchItem {
  final int? id;
  final String title;
  final String release_date;
  final String cover_img;
  final String description;
  final DateTime createdTime;

  const WatchItem(
      {this.id,
      required this.title,
      required this.release_date,
      required this.cover_img,
      required this.description,
      required this.createdTime});

  Map<String, Object?> toJson() => {
        WatchItemFields.id: id,
        WatchItemFields.title: title,
        WatchItemFields.release_date: release_date,
        WatchItemFields.cover_img: cover_img,
        WatchItemFields.description: description,
        WatchItemFields.time: createdTime.toIso8601String(),
      };

  // Copy the current note object
  WatchItem copy({
    int? id,
    String? title,
    String? release_date,
    String? cover_img,
    String? description,
    DateTime? createdTime,
  }) =>
      WatchItem(
          id: id ?? this.id,
          title: title ?? this.title,
          release_date: release_date ?? this.release_date,
          cover_img: cover_img ?? this.cover_img,
          description: description ?? this.description,
          createdTime: createdTime ?? this.createdTime);

  static WatchItem fromJson(Map<String, Object?> json) => WatchItem(
        id: json[WatchItemFields.id] as int?,
        title: json[WatchItemFields.title] as String,
        release_date: json[WatchItemFields.release_date] as String,
        cover_img: json[WatchItemFields.cover_img] as String,
        description: json[WatchItemFields.description] as String,
        createdTime: DateTime.parse(json[WatchItemFields.time] as String),
      );
}
