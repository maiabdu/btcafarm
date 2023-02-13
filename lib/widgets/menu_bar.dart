import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String val;
  const MenuItem({Key? key, required this.title, required this.val})
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(
                      'assets/img/btca1.png',
                      width: 40,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      val,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'BTCA',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '~USDT 0',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(.5),
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
