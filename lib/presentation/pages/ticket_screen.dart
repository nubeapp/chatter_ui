import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ui/extensions/extensions.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget customAppBar() => AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Tickets'),
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(
              CupertinoIcons.chevron_left,
              size: 26,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );

    BoxDecoration backgroundGradient() => const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF507188),
              Color(0xFFABB7C1),
            ],
          ),
        );

    return Container(
      decoration: backgroundGradient(),
      child: Scaffold(
        appBar: customAppBar(),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: context.w * 0.7,
                  height: context.h * 0.76,
                  child: Stack(
                    children: [
                      Container(
                        height: context.h * 0.5,
                        width: context.w * 0.7,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://picsum.photos/id/10/1024/1024',
                                fit: BoxFit.cover,
                                width: context.w * 0.7,
                                height: context.h * 0.25,
                              ),
                            ),
                            const Text(
                              'Antonio Diaz: El Mago Pop',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                height: 2,
                              ),
                            ),
                            const Text(
                              '-  -  -  -  -  -  -  -  -  -  -  -  -',
                              style: TextStyle(fontSize: 18, color: Colors.black12),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Dec 07, 2023',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '18:00',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: context.h * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Venue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'Seat',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Wizink Center',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'No seat',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: context.h * 0.4999,
                        child: ClipPath(
                          clipper: TicketShapeClipper(width: context.w, height: context.h),
                          child: Container(
                            color: Colors.white,
                            width: context.w * 0.7,
                            height: context.h * 0.0095,
                          ),
                        ),
                      ),
                      Positioned(
                        top: context.h * 0.5095,
                        child: Container(
                          height: context.h * 0.25,
                          width: context.w * 0.7,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                            child: SfBarcodeGenerator(
                              symbology: QRCode(),
                              value: 'ABCDEFGHIJKLMNOPQRST',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: context.h * 0.495,
                        left: context.w * 0.05,
                        child: const Text(
                          '-  -  -  -  -  -  -  -  -  -  -  -  -',
                          style: TextStyle(fontSize: 18, color: Colors.black38),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TicketShapeClipper extends CustomClipper<Path> {
  final double width;
  final double height;

  TicketShapeClipper({required this.width, required this.height});

  @override
  Path getClip(Size size) {
    final containerPath = Path();
    final rightPath = Path();
    final leftPath = Path();

    final container = containerPath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width,
          height,
        ),
      );

    final right = rightPath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          width * 0.67,
          0,
          width,
          height * 0.01,
          topLeft: const Radius.circular(10),
          bottomLeft: const Radius.circular(10),
        ),
      )
      ..close();

    final left = leftPath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width * 0.03,
          height * 0.01,
          topRight: const Radius.circular(10),
          bottomRight: const Radius.circular(10),
        ),
      )
      ..close();

    final newPath = Path.combine(PathOperation.difference, Path.combine(PathOperation.difference, container, right), left);

    return newPath;
  }

  @override
  bool shouldReclip(TicketShapeClipper oldClipper) => true;
}
