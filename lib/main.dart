

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/model/BookModel.dart';
import 'package:secondtest/provider/GetAllBookProvider.dart';


void main() {

  runApp(MultiProvider(providers: [
    ListenableProvider<GetAllBookProvider>(create: (_) => GetAllBookProvider()),
  ],
    child:const MaterialApp(
      home: MyHomePage(),
    ))
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
   late GetAllBookProvider dataProvider;
   late TabController _tabController;

   @override
   void initState() {
     super.initState();
     _tabController = TabController(length: 3, vsync: this);
   }
   @override
   void dispose() {
     _tabController.dispose();
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {

     dataProvider = Provider.of<GetAllBookProvider>(context);
     dataProvider.fetchData();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.draw_rounded),
            onPressed: () {},
          ),
          centerTitle: true,
          title: const Text("HOME"),
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_ethernet_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              interestList(),
               tabBar()
            ],
          ),
        ),
    );
  }

  Widget header(){
    return  SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 5),
            child: Text(
              "Your interest",
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15, top: 5),
            child: Text(
              "show All",
              style: GoogleFonts.roboto(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget interestList(){
    return SizedBox(
      height: 300,
      child: dataProvider.books.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),)
          : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dataProvider.books.length,
          itemBuilder: (BuildContext context, index) {
            return items(dataProvider.books[index]);
          }),
    );
  }

  Widget items(BookModel book){
    return SizedBox(
      width: 200,
      height: 300,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Stack(
          children: [
            Positioned(
              top: 60,
                  child:Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 200,
                        height: 160,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(247, 182, 204, 0.5),
                              spreadRadius: 15,
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                         ),
                    ),
                  ),
            ),
            Positioned(
              left: 30,
              right: 30,
              top: 10,
              child:  SizedBox(
                height: 180,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 5.0,
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => newsdetail(data)),
                      // );
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:Image.network(book.downloadUrl ?? 'https://img.lovepik.com/photo/20211122/small/lovepik-simple-home-picture_500717659.jpg',
                          fit: BoxFit.fitHeight,),
                      ),
                    )
                  ),
                ),
              ),
            ),
            Positioned(
              top: 220,
              child: Container(
                width: 200,
                height: 40,
                color: Colors.cyan,
                child: Center(child: Text(book.author!,
                style: GoogleFonts.breeSerif(
                    fontSize: 14, fontWeight: FontWeight.bold),)),
              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget tabBar(){
     return SizedBox(
       width: double.infinity,
       height: 500,
       child: Column(
         children: [
          Align(
            alignment: Alignment.topLeft,
            child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.blueGrey,
                tabs:  [
                  Tab(child: Text("Explore",style: GoogleFonts.spaceMono(
                     fontWeight:FontWeight.w500),)),
                  Tab(child: Text("BestSeller",style: GoogleFonts.spaceMono(
                      fontWeight:FontWeight.w500),)),
                  Tab(child: Text("Newest",style: GoogleFonts.spaceMono(
                      fontWeight:FontWeight.w500),)),
                ],
              ),
          ),
           Expanded(
             child: TabBarView(
               controller: _tabController,
               children: [
                 Container(
                   child: testing(),
                 ),
                 Container(
                   child: bestSeller(),
                 ),
                 const Center(child: Text('Tab 3 content')),
               ],
             ),
           ),
         ],
    ),
     );
  }

  Widget bestSeller(){
     return GridView.count(
       crossAxisCount: 2,
       childAspectRatio: 0.7, // Number of columns in the grid
       children: List.generate(
             dataProvider.books.length,
              // Number of items in the grid
             (index) {
           // return interestList();
           return Container(
             margin: EdgeInsets.all(5),
             child: items(dataProvider.books[index])
           );

         },
       ),
     );
  }

  Widget testing() {
    return Column(
      children: [
        ElevatedButton(
            onPressed: (){},
            child: Text("Test")
        )
      ],
    );
  }
}
