import 'package:ets_cinema_app/database/watch_item_db.dart';
import 'package:ets_cinema_app/model/watch_item.dart';
import 'package:ets_cinema_app/widgets/watch_form_widget.dart';
import 'package:flutter/material.dart';

class AddEditWatchItem extends StatefulWidget {
  final WatchItem? watchItem;

  const AddEditWatchItem({Key? key, this.watchItem}) : super(key: key);

  @override
  State<AddEditWatchItem> createState() => _AddEditWatchItemState();
}

class _AddEditWatchItemState extends State<AddEditWatchItem> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String release_date;
  late String cover_img;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.watchItem?.title ?? '';
    release_date = widget.watchItem?.release_date ?? '';
    cover_img = widget.watchItem?.cover_img ?? '';
    description = widget.watchItem?.description ?? '';
  }

  Widget saveButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;
    return IconButton(
        onPressed: addOrWatchItem,
        icon: Icon(
          Icons.save_rounded,
          color: isFormValid ? Colors.white : Colors.grey[800],
        ));
  }

  void addOrWatchItem() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      // Check whether watch item already exists or not
      final isUpdating = widget.watchItem != null;

      // If it exist, then we update
      if (isUpdating) {
        await updateWatchItem();
      }
      // If it doesn't then we add
      else {
        await addWatchItem();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateWatchItem() async {
    final watch_item = widget.watchItem!.copy(
      title: title,
      release_date: release_date,
      cover_img: cover_img,
      description: description,
    );

    await WatchItemDB()
        .update(watch_item); // Changed to WatchItemDB().update(note)
  }

  Future addWatchItem() async {
    final watch_item = WatchItem(
      title: title,
      release_date: release_date,
      cover_img: cover_img,
      description: description,
      createdTime: DateTime.now(),
    );
    await WatchItemDB()
        .create(watch_item); // Changed to WatchItemDB().create(note)
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating = widget.watchItem != null;
    final appbar_title = isUpdating ? 'Edit Watch Item' : 'Add Watch Item';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          appbar_title.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'BebasNeue',
            letterSpacing: 2,
            fontSize: 30,
            color: Colors.red,
          ),
        ),
        actions: [saveButton()],
        shape: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 2)),
      ),
      body: Form(
        key: _formKey,
        child: WatchFormWidget(
          title: title,
          description: description,
          release_date: release_date,
          cover_img: cover_img,
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedReleaseDate: (release_date) =>
              setState(() => this.release_date = release_date),
          onChangedCoverImg: (cover_img) =>
              setState(() => this.cover_img = cover_img),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
        ),
      ),
    );
  }
}
