import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_cinema_app/database/watch_item_db.dart';
import 'package:ets_cinema_app/model/watch_item.dart';
import 'package:ets_cinema_app/pages/add_edit_watch_item.dart';

class WatchItemDetail extends StatefulWidget {
  final int watchItemId;

  const WatchItemDetail({Key? key, required this.watchItemId}) : super(key: key);

  @override
  State<WatchItemDetail> createState() => _WatchItemDetailState();
}

class _WatchItemDetailState extends State<WatchItemDetail> {
  late WatchItem watchItem;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshWatchItem();
  }

  Future refreshWatchItem() async {
    setState(() => isLoading = true);
    this.watchItem = await WatchItemDB().viewWatchItem(widget.watchItemId); // Adjusted this line
    setState(() => isLoading = false);
  }

  Widget editButton() => IconButton(
    onPressed: () async {
      if (isLoading) return;
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditWatchItem(watchItem: watchItem),
      ));
      refreshWatchItem();
    },
    icon: const Icon(Icons.edit_outlined, color: Colors.white),
  );

  Widget deleteButton() => IconButton(
    onPressed: () async {
      await WatchItemDB().delete(widget.watchItemId); // Adjusted this line
      Navigator.of(context).pop();
    },
    icon: const Icon(Icons.delete, color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [editButton(), deleteButton()],
        shape: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 2)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(watchItem.cover_img)
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    watchItem.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                      letterSpacing: 2.0,
                      fontFamily: 'BebasNeue',
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 12.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        '•', // The text
                        style: TextStyle(
                          fontSize: 32 / 1.618,
                          letterSpacing: 2.0,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${watchItem.release_date}', // The text
                        style: TextStyle(
                          fontSize: 32 / 1.618,
                          letterSpacing: 2.0,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '•', // The text
                        style: TextStyle(
                          fontSize: 32 / 1.618,
                          letterSpacing: 2.0,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Transform.scale(
                scale: 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[850],
                      child: IconButton(
                        icon: const Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[850],
                      child: IconButton(
                        icon: const Icon(
                          Icons.reviews_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Watch now',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const FavoriteButton(),
                    CircleAvatar(
                      backgroundColor: Colors.grey[850],
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey[800],
              height: 30,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: Text(
                watchItem.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey[850],
      child: IconButton(
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          )),
    );
  }
}