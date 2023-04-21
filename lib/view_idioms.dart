import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'idiom.dart';

class ViewIdioms extends StatefulWidget {
  @override
  State<ViewIdioms> createState() => _ViewIdiomsState();
}

class _ViewIdiomsState extends State<ViewIdioms> {
  var color;
  var data = FirebaseFirestore.instance
      .collection("idioms")
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
                                  builder: (context) => Idiom(
                                      snapshot.data!.docs[index]['idiom'],
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
                              snapshot.data!.docs[index]['idiom'],
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.kalam(
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
