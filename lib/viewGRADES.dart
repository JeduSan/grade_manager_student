import 'package:euc_grading_system/classes/subject.dart';
import 'package:flutter/material.dart';
// import 'package:euc_grading_system/classes/sem.dart';
import 'package:euc_grading_system/helpers/fetch_sem.dart';
import 'package:euc_grading_system/helpers/fetch_subject.dart';
import 'package:euc_grading_system/about.dart';
import 'login.dart';

class ViewGrades extends StatefulWidget {
  final int user_id;

  const ViewGrades({required this.user_id});

  @override
  _ViewGradesState createState() => _ViewGradesState();
}

class _ViewGradesState extends State<ViewGrades> {
  String selectedSemester = 'Select Semester';
  int selectedSemesterId = 0;
  Future<Subject>? futureSubject;
  // int sem_id = 0;
  // late Future<Sem> _sem;

  // For populating pop menu button
  List<PopupMenuItem<String>> semesters = [];

  @override
  void initState() {
    super.initState();
    // _sem = fetchSem(widget.user_id);

    fetchSem(widget.user_id).then((data) {
      List sems = data.semData;
      // print("SEMS: ${sems}");

      // REVIEW: Show initial value to the dropdown
      // setState(() {
      //   if (sems[0]["sem"] == 1) {
      //     // This is for the initial selected item
      //     selectedSemester = "1st Semester ${sems[0]["academic_year"]}";
      //   } else if (sems[0]["sem"] == 2) {
      //     // This is for the initial selected item
      //     selectedSemester = "2nd Semester ${sems[0]["academic_year"]}";
      //   } else if (sems[0]["sem"] == 3) {
      //     // This is for the initial selected item
      //     selectedSemester = "Summer ${sems[0]["academic_year"]}";
      //   }
      // });

      // print(selectedSemesterId);

      sems.forEach((sem) {
        // print("SEM: ${sem}");

        if (sem["sem"] == 1) {
          setState(() {
            semesters.add(
              PopupMenuItem(
                // value: sem["sem_id"].toString(),
                value:
                    "1st Semester ${sem["academic_year"]} (${sem["sem_id"]})",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "1st Semester ${sem["academic_year"]}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 162, 16, 5),
                    ),
                  ),
                ),
              ),
            );
          });
        } else if (sem["sem"] == 2) {
          setState(() {
            semesters.add(
              PopupMenuItem(
                // value: sem["sem_id"].toString(),
                value:
                    "2nd Semester ${sem["academic_year"]} (${sem["sem_id"]})",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "2nd Semester ${sem["academic_year"]}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 162, 16, 5),
                    ),
                  ),
                ),
              ),
            );
          });
        } else if (sem["sem"] == 3) {
          setState(() {
            semesters.add(
              PopupMenuItem(
                // value: sem["sem_id"].toString(),
                value: "Summer ${sem["academic_year"]} (${sem["sem_id"]})",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Summer ${sem["academic_year"]}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 162, 16, 5),
                    ),
                  ),
                ),
              ),
            );
          });
        }
      });
    });

    // print("SEMESTERS: ${semesters}");
  }

  Future<void> _handleLogout(BuildContext context) async {
    bool confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('\nAre you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Color.fromARGB(255, 162, 16, 5),
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirm) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // _sem.then((data) {
    //   List sems = data.semData;
    //   print("SEMS: ${sems}");

    //   sems.forEach((sem) {
    //     print("SEM: ${sem}");

    //     if (sem["sem"] == 1) {
    //       setState(() {
    //         semesters.add("1st Semester ${sem["academic_year"]}");
    //       });
    //     } else if (sem["sem"] == 2) {
    //       setState(() {
    //         semesters.add("2nd Semester ${sem["academic_year"]}");
    //       });
    //     } else if (sem["sem"] == 3) {
    //       setState(() {
    //         semesters.add("Summer ${sem["academic_year"]}");
    //       });
    //     }
    //   });
    // });

    // print("SEMESTERS: ${semesters}");

    // print("SELECTED VALUE POPMENU: ${selectedSemester}");

    // // set initial data for the menu
    // selectedSemester = semesters[0].value!;

    // print(selectedSemesterId);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 162, 16, 5),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.3)
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // [x] Delete later, for testing only
                                // Text(widget.user_id.toString()),
                                Text(
                                  'VIEW GRADES',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 16, 5),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                // REVIEW:POP MENU BUTTON
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 162, 16, 5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: PopupMenuButton<String>(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 16,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              selectedSemester,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Icon(Icons.arrow_drop_down,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                      onSelected: (String value) {
                                        setState(() {
                                          // selectedSemester = value;
                                          // Regex for removing parenthesis and its contents
                                          selectedSemester = value.replaceAll(
                                              RegExp(r'\s*\(.*?\)\s*'), '');

                                          // Regex to extract the number inside parentheses
                                          RegExp regex = RegExp(r'\((\d+)\)');

                                          // Extract the first match
                                          Match? match =
                                              regex.firstMatch(value);

                                          if (match != null) {
                                            selectedSemesterId = int.parse(
                                                match.group(
                                                    1)! // Get the captured group
                                                );

                                            // print(
                                            //   "Extracted number: $selectedSemesterId",
                                            // );
                                            // sem_id =
                                            //     int.parse(selectedSemester);

                                            // print(sem_id);
                                          } else {
                                            // print(
                                            //     "No number found in parentheses.");
                                          }
                                        });

                                        // REVIEW: Every select, fetch subjects
                                        // fetchSubject(widget.user_id,
                                        //         selectedSemesterId)
                                        //     .then((data) {
                                        //   print("SUBJECT: $data");

                                        // }, onError: (e) {
                                        //   print("ERROR FETCHING SUBJECTS: $e");
                                        // });

                                        futureSubject = fetchSubject(
                                            widget.user_id, selectedSemesterId);
                                      },
                                      itemBuilder: (context) => semesters
                                      // .map((semester) => PopupMenuItem(
                                      //       value: semester,
                                      //       child: Container(
                                      //         decoration: BoxDecoration(
                                      //           color: Colors.transparent,
                                      //           borderRadius:
                                      //               BorderRadius.circular(8),
                                      //         ),
                                      //         child: Text(
                                      //           semester,
                                      //           style: TextStyle(
                                      //             color: Color.fromARGB(
                                      //                 255, 162, 16, 5),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ))
                                      // .toList(),
                                      ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SUBJECTS',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Text(
                                      'GRADES',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          //   itemCount: 8,
                          //   itemBuilder: (context, index) {
                          //     return _buildGradeCard(index);
                          //   },
                          // ),
                          FutureBuilder(
                              future: futureSubject,
                              builder: (context, snapshot) {
                                // final bool isEven = index % 2 == 0;
                                // print("SNAPSHOT: $snapshot");
                                if (snapshot.hasData) {
                                  // final bool isEven = index % 2 == 0;
                                  // print(snapshot.data!.semData);
                                  // ListView.builder(
                                  //   shrinkWrap: true,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  //   // itemCount: 8,
                                  //   itemBuilder: (context, index) {
                                  //     return _buildGradeCard(index, snapshot);
                                  //   },
                                  // );

                                  // print(snapshot);

                                  var data = snapshot.data!.semData;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      // print("SNAPSHOT: $data");
                                      var item = data[index];

                                      // print("<ITEM>: $item");
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          // color: isEven
                                          //     ? Colors.white
                                          //     : Colors.grey[50],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.2)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${item["subject_code"]} · ${item["units"]} unit/s',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${item["subject"]}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      (item["score"] != null)
                                                          ? '${item["score"]}'
                                                          : "Pending",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      // passing grade is 3.00
                                                      (item["score"] != null)
                                                          ? (item["score"] <=
                                                                      3 &&
                                                                  item["score"] >
                                                                      0)
                                                              ? 'PASSED'
                                                              : (item["score"] >
                                                                      3)
                                                                  ? 'FAILED'
                                                                  : 'INC'
                                                          : 'PENDING',

                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text(
                                                  'Instructor: ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  (item["fname"] != null &&
                                                          item["lname"] != null)
                                                      ? '${item["fname"]} ${item["lname"]}'
                                                      : 'TBA',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _buildInfoRow(
                                                        'Section:',
                                                        (item["section"] !=
                                                                null)
                                                            ? '${item["section"]}'
                                                            : 'TBA'),
                                                    // _buildInfoRow(
                                                    //     'Days:', 'MWF'),
                                                  ],
                                                ),
                                                // Column(
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.start,
                                                //   children: [
                                                //     _buildInfoRow(
                                                //         'Class Room:', '1'),
                                                //     _buildInfoRow(
                                                //         'Time:', '5:00 - 6:00'),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );

                                  // return Container(
                                  //   margin: EdgeInsets.only(bottom: 16),
                                  //   padding: EdgeInsets.all(16),
                                  //   decoration: BoxDecoration(
                                  //     // color: isEven
                                  //     //     ? Colors.white
                                  //     //     : Colors.grey[50],
                                  //     color: Colors.white,
                                  //     borderRadius: BorderRadius.circular(12),
                                  //     border: Border.all(
                                  //         color: Colors.grey.withOpacity(0.2)),
                                  //   ),
                                  //   child: Column(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         'SAMPLE · 3 unit/s',
                                  //         style: TextStyle(
                                  //           fontSize: 13,
                                  //           color: Colors.grey[700],
                                  //         ),
                                  //       ),
                                  //       SizedBox(height: 4),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Expanded(
                                  //             child: Text(
                                  //               'SUBJECT',
                                  //               style: TextStyle(
                                  //                 fontSize: 16,
                                  //                 fontWeight: FontWeight.bold,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.end,
                                  //             children: [
                                  //               Text(
                                  //                 '1.25',
                                  //                 style: TextStyle(
                                  //                   fontSize: 24,
                                  //                   fontWeight: FontWeight.bold,
                                  //                 ),
                                  //               ),
                                  //               Text(
                                  //                 'PASSED',
                                  //                 style: TextStyle(
                                  //                   fontSize: 12,
                                  //                   color: Colors.green,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(height: 8),
                                  //       Row(
                                  //         children: [
                                  //           Text(
                                  //             'Instructor: ',
                                  //             style: TextStyle(
                                  //               fontSize: 12,
                                  //               color: Colors.grey[600],
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             'Juan Mapagmahal',
                                  //             style: TextStyle(
                                  //               fontSize: 12,
                                  //               color: Colors.red,
                                  //               fontWeight: FontWeight.w500,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(height: 8),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               _buildInfoRow(
                                  //                   'Section:', 'LA-RLWW1'),
                                  //               _buildInfoRow('Days:', 'MWF'),
                                  //             ],
                                  //           ),
                                  //           Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               _buildInfoRow(
                                  //                   'Class Room:', '1'),
                                  //               _buildInfoRow(
                                  //                   'Time:', '5:00 - 6:00'),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // );
                                }

                                return Column(
                                  children: [
                                    const CircularProgressIndicator(
                                      color: Colors.redAccent,
                                      strokeCap: StrokeCap.round,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Please select a semester',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          // Positioned Back Button
          Positioned(
            top: 40, // Adjust the vertical position as needed
            left: 16, // Place it on the left side
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white, // Set the icon color
                size: 28, // Set the icon size
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Navigate back to the previous page
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: PopupMenuButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: 28,
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 162, 16, 5),
                      ),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'about',
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color.fromARGB(255, 162, 16, 5),
                      ),
                      SizedBox(width: 8),
                      Text('About'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'logout') {
                  _handleLogout(context);
                } else if (value == 'about') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeCard(int index, var snapshot) {
    final bool isEven = index % 2 == 0;
    // print(snapshot);

    // var data = snapshot.data!.semData;

    // print(data);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEven ? Colors.white : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SAMPLE · 3 unit/s',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'SUBJECT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '1.25',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'PASSED',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Instructor: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Juan Mapagmahal',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Section:', 'LA-RLWW1'),
                  _buildInfoRow('Days:', 'MWF'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Class Room:', '1'),
                  _buildInfoRow('Time:', '5:00 - 6:00'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
