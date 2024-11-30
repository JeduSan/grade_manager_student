import 'package:euc_grading_system/classes/student.dart';
import 'package:euc_grading_system/helpers/fetch_student.dart';
import 'package:flutter/material.dart';
import 'viewGRADES.dart';
import 'package:euc_grading_system/about.dart';
import 'login.dart';

class StudentDashboard extends StatefulWidget {
  final int user_id;

  const StudentDashboard({required this.user_id});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  late Future<Student> _futureStudent;
  String _fullname = '';
  String _course = '';
  var _gwa = 0.0;
  String _scholarship_type = '';
  int _total_units = 0;
  Map<String, dynamic> _grade_status = {};
  int _total_subjects = 0;

  @override
  void initState() {
    super.initState();
    _futureStudent = fetchStudent(widget.user_id);
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
    // REVIEW: Auto refresh on new data
    // setState(() {
    //   _futureStudent = fetchStudent(widget.user_id);
    // });

    _futureStudent.then((student) {
      // print(student.fullname);

      setState(() {
        _fullname = student.fullname;
        _course = student.course;
        _gwa = student.gwa;
        _scholarship_type = student.scholarship_type;
        _total_units = student.total_units;
        _grade_status = student.grade_status;
        _total_subjects = _grade_status["completed"] +
            _grade_status["pending"] +
            _grade_status["failed"] +
            _grade_status["inc"];
      });
    }, onError: (e) {
      print("ERROR HERE: ${e}");
    });

    return RefreshIndicator(
      onRefresh: () async {
        // REVIEW: Auto refresh on new data
        setState(() {
          _futureStudent = fetchStudent(widget.user_id);
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 332,
                      ),
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
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Hello ${_fullname}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 162, 16, 5),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      _course,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Manuel S. Enverga University Foundation Candelaria Inc.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewGrades(
                                              user_id: widget.user_id),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 162, 16, 5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        'View Grades',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _buildInfoCard(
                            'GWA for current semester',
                            _gwa.toString(),
                            Colors.black,
                            Colors.white,
                            Color.fromARGB(255, 162, 16, 5)),
                        _buildInfoCard(
                            'You are eligible for',
                            _scholarship_type,
                            Colors.black,
                            Colors.white,
                            Color.fromARGB(255, 162, 16, 5),
                            specialFontSize: 14.0),
                        _buildInfoCard(
                            'Total Units',
                            _total_units.toString(),
                            Colors.white,
                            Color.fromARGB(255, 162, 16, 5),
                            Colors.white),
                        _buildInfoCard(
                            'Total Subjects',
                            _total_subjects.toString(),
                            Colors.white,
                            Color.fromARGB(255, 162, 16, 5),
                            Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Grade Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: const Color.fromARGB(255, 162, 16, 5),
                            ),
                          ),
                          Divider(color: Colors.black),
                          SizedBox(height: 6),
                          _buildGradeStatusRow(
                              'Complete',
                              _grade_status["completed"].toString(),
                              Colors.black),
                          _buildGradeStatusRow(
                              'Pending',
                              _grade_status["pending"].toString(),
                              Colors.black),
                          _buildGradeStatusRow('INC',
                              _grade_status["inc"].toString(), Colors.black),
                          _buildGradeStatusRow('Failed',
                              _grade_status["failed"].toString(), Colors.black),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
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
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color valueColor,
      Color backgroundColor, Color titleColor,
      {double? specialFontSize}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 16,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: specialFontSize ?? 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeStatusRow(String status, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
