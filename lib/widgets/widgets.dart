import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../functions/functions.dart';
import '../models/hotelModel.dart';

class MenuItem extends StatefulWidget {
  final String title;
  final String val;
  final String passport_no;
  const MenuItem(
      {Key? key,
      required this.title,
      required this.val,
      required this.passport_no})
      : super(
          key: key,
        );

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  String house = 'Nill', floor = 'Nill', room = 'Nill', bed = 'Nill';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchAccomodation(widget.passport_no).then((value) {
      setState(() {
        print(value);
        FetchHotel hotel = value;
        house = hotel.hotel;
        floor = hotel.floor;
        room = hotel.room;
        bed = hotel.bed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    // String? house;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: Get.width * 0.42,
      height: 200,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ]),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Center(
        child: SizedBox(
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.account_balance,
                        color: Theme.of(context).primaryColor,
                      )),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'House: ' + house.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Floor: ' + floor,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Room No: ' + room,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Bed No: ' + bed,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text('USDT', style: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    //   fontSize: 10,
                    //   fontWeight: FontWeight.w500,
                    // ),)
                    const SizedBox(
                      height: 10,
                    ),

                    house == '' || house == null ?
                    GestureDetector(
                      onTap: () async {
                        //  await openMap(37.751, -97.822);
                        // pushMap('37.751', '-97.822');
                        MapsLauncher.launchCoordinates(
                            10.531850, 7.429470, 'Your Hotel is Here');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).primaryColor),
                        // decoration: BoxDecoratio
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Text(
                            'Navigate to Hotel',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ) :   GestureDetector(
                      onTap: () async {
                        //  await openMap(37.751, -97.822);
                        // pushMap('37.751', '-97.822');
                        MapsLauncher.launchCoordinates(
                            21.402887, 39.817918, 'Your Hotel is Here');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).primaryColor),
                        // decoration: BoxDecoratio
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Text(
                            'Go Hotel',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeQr extends StatelessWidget {
  final String val;
  const HomeQr({Key? key, required this.val})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: Get.width * 0.42,
      height: 150,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ]),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Center(
        child: SizedBox(
          height: 120,
          child: QrImage(
            data: val,
            size: 110,
            // Widget builTextField(context),
          ),
        ),
      ),
    );
  }
}

class MenuItem1 extends StatelessWidget {
  final String val;
  const MenuItem1({Key? key, required this.val})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: Get.width * 0.42,
      height: 150,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ]),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Center(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assured_workload,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      val,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(1),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text('USDT', style: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    //   fontSize: 10,
                    //   fontWeight: FontWeight.w500,
                    // ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem2 extends StatelessWidget {
  final String val;
  const MenuItem2({Key? key, required this.val})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: Get.width * 0.42,
      height: 150,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ]),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Center(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      val,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text('USDT', style: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    //   fontSize: 10,
                    //   fontWeight: FontWeight.w500,
                    // ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem3 extends StatelessWidget {
  final String val;
  const MenuItem3({Key? key, required this.val})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: Get.width * 0.42,
      height: 150,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ]),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Center(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flight_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      val,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text('USDT', style: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    //   fontSize: 10,
                    //   fontWeight: FontWeight.w500,
                    // ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem4 extends StatelessWidget {
  final String val;
  const MenuItem4({Key? key, required this.val})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: Get.width * 0.42,
      height: 150,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ]),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Center(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bus_alert,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      val,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text('USDT', style: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    //   fontSize: 10,
                    //   fontWeight: FontWeight.w500,
                    // ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuDasbhaord extends StatelessWidget {
  final String title, description;
  const MenuDasbhaord(
      {Key? key, required this.title, required this.description})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: Get.width * 0.42,
      height: 150,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ]),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Center(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.person_2,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      description,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )

                    // Text('USDT', style: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    //   fontSize: 10,
                    //   fontWeight: FontWeight.w500,
                    // ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
