import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jellywaves/home/library/tabs/albums.dart';


class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override 
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin{
  late final TabController _tabController;

  final tabs = ["Albums", "Artists", "Genres", "Playlists", "Songs"];

  @override 
  void initState() {
    super.initState();

    _tabController=TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override 
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xff1A1A1A),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff1A1A1A),
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor:  Color(0xffDDC6A7),
                unselectedLabelColor: Color(0xffDDC6A7),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 10),
                labelPadding: EdgeInsets.symmetric(horizontal: 2),

                tabs: List.generate(tabs.length, (index) {
                  final isActive = _tabController.index == index;

                  return Tab(
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isActive ? Color(0xffB83A2E) : Color(0xff4E6851),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Text(
                        tabs[index]
                      ),
                    )
                  );
                }),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AlbumsTab(),
                    Center(child: Text("TODO", style: TextStyle(color: Colors.white))),
                    Center(child: Text("TODO", style: TextStyle(color: Colors.white))),
                    Center(child: Text("TODO", style: TextStyle(color: Colors.white))),
                    Center(child: Text("TODO", style: TextStyle(color: Colors.white))),
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }

  @override 
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
