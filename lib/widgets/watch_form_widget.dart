import 'package:flutter/material.dart';

class WatchFormWidget extends StatelessWidget {
  final String? title;
  final String? release_date;
  final String? cover_img;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedReleaseDate;
  final ValueChanged<String> onChangedCoverImg;
  final ValueChanged<String> onChangedDescription;

  const WatchFormWidget({
    Key? key,
    this.title = '',
    this.release_date = '',
    this.cover_img = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedReleaseDate,
    required this.onChangedCoverImg,
    required this.onChangedDescription,
  }) : super(key: key);

  Widget buildTitle() => TextFormField(
        maxLines: null,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildReleaseDate() => TextFormField(
        maxLines: 1,
        initialValue: release_date,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'N/A..',
          hintStyle: TextStyle(color: Colors.white),
        ),
        validator: (release_date) => release_date != null && release_date.isEmpty
            ? 'Release date cannot be empty'
            : null,
        onChanged: onChangedReleaseDate,
      );

  Widget buildCoverImg() => Column(
    children: [
      Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: cover_img != null ? Image.asset('images/poster_placeholder.jpg') : Image.network(cover_img!),
        ),
      ),
      TextFormField(
            maxLines: 1,
            initialValue: cover_img,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter cover image link or url..',
              hintStyle: TextStyle(color: Colors.white),
            ),
            validator: (cover_img) => cover_img != null && cover_img.isEmpty
                ? 'Cover image cannot be empty'
                : null,
            onChanged: onChangedCoverImg,
          ),
    ],
  );

  Widget buildDescription() => TextFormField(
    textAlign: TextAlign.justify,
        maxLines: null,
        initialValue: description,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white),
        ),
        validator: (description) => description != null && description.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildCoverImg(),
            buildTitle(),
            buildReleaseDate(),
            buildDescription(),
          ],
        ),
      ),
    );
  }
}
