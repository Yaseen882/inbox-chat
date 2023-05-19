import 'package:chat_inbox_flutter/config/app_constants.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double bottomPosition;
  final double rightPosition;
  final ImageProvider? image;
  final bool isAssetImage;
  final bool isEditable;
  final VoidCallback? pickOnTap;

  const CustomAvatar({
    Key? key,
    this.child,
    this.radius = 35.0,
    this.image,
    this.isAssetImage = false,
    this.isEditable = false,
    this.bottomPosition = 20,
    this.rightPosition = 0.0,
    this.pickOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEditable
        ? Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: radius,
                backgroundColor: Colors.white,
                // backgroundImage: image,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                     shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 3.0),
                    image: DecorationImage(image: image!, fit: BoxFit.fill,),
                  ),
                ),
              ),
              Positioned(
                right: rightPosition,
                bottom: bottomPosition,
                child: InkWell(
                  onTap: pickOnTap,
                  child: const CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          )
        : CircleAvatar(
            radius: radius,
            backgroundColor: Colors.black,
            backgroundImage: image,
            child: child,
          );
  }
}
