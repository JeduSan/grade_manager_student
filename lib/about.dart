import 'package:euc_grading_system/classes/student.dart';
import 'package:euc_grading_system/helpers/fetch_student.dart';
import 'package:flutter/material.dart';
// import 'viewGRADES.dart';
import 'login.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
                                Text(
                                  'ABOUT EUC GRADING SYSTEM (Student)',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 16, 5),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Project Managers',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Noel Cuevas, Allan Steven Meliton'),
                                SizedBox(height: 16),
                                Text(
                                  'UI/UX Designer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Alliah Mikaela Revedezo'),
                                SizedBox(height: 16),
                                Text(
                                  'Frontend Developer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                    'Luigi Montalban, Alliah Mikaela Revedezo'),
                                SizedBox(height: 16),
                                Text(
                                  'Backend Developer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Jed Benedict Loba, Allan Steven Meliton'),
                                SizedBox(height: 16),
                                Text(
                                  'Database Manager',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Ronnel Panergalin, Noel Cuevas'),
                                SizedBox(height: 16),
                                Text(
                                  'API Integration Specialist',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Jed Benedict Loba'),
                                SizedBox(height: 16),
                                Text(
                                  'Tester/QA Specialist',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                    'Justin Ralphlino Patulot, Joice Ann Macatangay, Kristal Jane Ramos'),
                                SizedBox(height: 16),
                                Text(
                                  'Documentation Specialist',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                    'Crizsa Aivy Beredo, Patrice Mhay Lugares'),
                                SizedBox(height: 16),
                                Text('© 2024 - College of Computer Science'),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
              Navigator.of(context).pop(); // Navigate back to the previous page
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
            ],
            onSelected: (value) {
              if (value == 'logout') {
                _handleLogout(context);
              }
            },
          ),
        ),
      ],
    ));
  }
}
