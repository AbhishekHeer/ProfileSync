import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/models/notes_model.dart';
import 'package:top_ai_assignment/screens/add_notes.dart';
import 'package:top_ai_assignment/screens/delete_screen.dart';
import 'package:top_ai_assignment/screens/logout_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              InkWell(
                onTap: () => Get.toNamed(LogoutScreen.routeName),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: width * .04,
                  child:
                      authController.userImage.value != ""
                          ? ClipOval(
                            child: Image.network(
                              authController.userImage.value,
                              fit: BoxFit.cover,
                              width: width * .14,
                              height: width * .14,
                            ),
                          )
                          : Center(child: Icon(CupertinoIcons.person)),
                ),
              ),

              SizedBox(width: width * .03, height: 0.0),
            ],
            backgroundColor: Colors.blue,
            pinned: true,
            floating: true,
            title: Text(
              'Welcome ${authController.userName.value != "" ? authController.userName.value : 'User'}',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * .04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          FutureBuilder<List<NotesModel>>(
            future: supabaseServiceController.getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              return SliverList.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  if (snapshot.data != null) {
                    final data = snapshot.data![index];
                    return Card(
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.symmetric(
                        vertical: height * .01,
                        horizontal: width * .03,
                      ),
                      child: ExpansionTile(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ID: ${data.id}',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Age: ${data.age}',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Address: ${data.address}',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Phone: ${data.number}',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(
                                    DeleteScreen.routeName,
                                    arguments: {"id": data.id},
                                  );
                                },
                                child: Text("Delete"),
                              ),
                            ],
                          ),
                        ],
                        title: Text(
                          data.address,
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            fontSize: width * .04,
                          ),
                        ),
                        subtitle: Text(
                          "Your Age : ${data.age.toString()}",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            fontSize: width * .03,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Notes Found",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: width * .04,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AddNotes.routeName);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
