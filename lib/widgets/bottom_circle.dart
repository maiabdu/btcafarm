import 'package:flutter/material.dart';


class BottomCircle extends StatefulWidget {
  final IconData icon;
  final Function()? onTap;
  const BottomCircle({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  State<BottomCircle> createState() => _BottomCircleState();
}

class _BottomCircleState extends State<BottomCircle> {
  bool isPressed = false;
  onPressed(){
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      // onTapDown: (e){onPressed();},
      // onTapUp:(e){onPressed();} ,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width:60,
        height:60,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(223, 228, 250, 1),
                  Color.fromRGBO(241, 243, 255, 1),
                  Color.fromRGBO(241, 243, 255, 1),
                ]
            ),
            shape: BoxShape.circle,
            boxShadow: [
              const BoxShadow(
                color: Color(0xffabb2ea),
                offset: Offset(4,4),
                spreadRadius: 1,
                blurRadius: 15,
              ),
              BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  offset:const Offset(-10,-10),
                  spreadRadius:1,
                  blurRadius:15

              ), // BoxShadow
            ]
        ),
        child: Center(
          child: SizedBox(
            height: 100,
            child: Icon(widget.icon, size: 35, color: Theme.of(context).primaryColor,)
          ),
        ),
      ),
    );
  }
}
