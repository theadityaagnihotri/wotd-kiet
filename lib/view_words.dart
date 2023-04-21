import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wotd_kiet/word.dart';

class ViewWords extends StatefulWidget {
  @override
  State<ViewWords> createState() => _ViewWordsState();
}

class _ViewWordsState extends State<ViewWords> {
  var color;
  var data = FirebaseFirestore.instance
      .collection("words")
      .orderBy('date', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(children: [
        StreamBuilder(
          stream: data,
          builder: ((context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, int index) {
                  color = Colors.black;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Word(
                                      snapshot.data!.docs[index]['word'],
                                      snapshot.data!.docs[index]['meaning'],
                                      snapshot.data!.docs[index]['eg1'],
                                      snapshot.data!.docs[index]['eg2'])));
                        },
                        child: Card(
                          color: color,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white)),
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              snapshot.data!.docs[index]['word'],
                              style: GoogleFonts.kalam(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]['meaning'],
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.pangolin(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
        ),
      ]),
    );
  }
}
