import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ets_cinema_app/database/watch_item_db.dart';
import 'package:ets_cinema_app/model/watch_item.dart';
import 'package:ets_cinema_app/pages/add_edit_watch_item.dart';
import 'package:ets_cinema_app/pages/watch_item_detail.dart';
import 'package:ets_cinema_app/widgets/watch_card_widget.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  late List<WatchItem> watchItems;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshWatchItems();
  }

  @override
  void dispose() {
    WatchItemDB().close(); // Adjusted this line
    super.dispose();
  }

  Future refreshWatchItems() async {
    setState(() => isLoading = true);
    watchItems = await WatchItemDB().viewAllWatchItem(); // Adjusted this line
    setState(() => isLoading = false);
  }

  Widget buildWatchItems() => StaggeredGrid.count(
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: List.generate(
      watchItems.length,
          (index) {
        final watchItem = watchItems[index];
        return StaggeredGridTile.fit(
            crossAxisCellCount: 2,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        WatchItemDetail(watchItemId: watchItem.id!)));
                refreshWatchItems();
              },
              child: WatchCardWidget(watchItem: watchItem, index: index,)
            ));
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            'WATCHLIST',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'BebasNeue',
              letterSpacing: 2,
              fontSize: 30,
              color: Colors.red,
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon:
          const Icon(
            Icons.search,
            color: Colors.white,
          ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: isLoading
            ? CircularProgressIndicator()
            : watchItems.isEmpty
            ? Center(
          child: const Text(
            'No WatchItems',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
            : buildWatchItems(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditWatchItem()),
          );
          refreshWatchItems();
        },
      ),
    );
  }
}
