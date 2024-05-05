import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/home_screen.dart';
import 'package:furniture_app/update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 86, 138, 250),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                          'images/436522443_464222692792917_6361338301564657820_n.jpg'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color:   Color.fromARGB(255, 86, 138, 250)),
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Jasser Rhouma",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "jasserrhouma180@gmail.com",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const  UpdateProfileScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:   Color.fromARGB(255, 86, 138, 250),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "Edite Profile",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              //menu
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.backpack_sharp,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Billing Details",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.manage_accounts,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "User Management",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.info_outlined,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Information",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut().whenComplete(() =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen())));
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.logout_sharp,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
