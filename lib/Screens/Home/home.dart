import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isHoveringOnLink = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobileScreen = constraints.maxWidth < 600;
        return SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              SizedBox(height: screenHeight * .04),
              SizedBox(
                width: screenWidth,
                // height: screenHeight,
                // color: Colors.white.withOpacity(.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Mobile App Developer | Flutter Developer',
                        style: TextStyle(
                          color: Color(0xFFfeb800),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Inas Nuzeer',
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: screenHeight * .04),
                    if (isMobileScreen) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _personalData1(),
                          const SizedBox(height: 30),
                          _personalData2(),
                        ],
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _personalData1(),
                          const SizedBox(width: 30),
                          _personalData2(),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * .03,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Open to Work',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _personalData1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _personalDataCard(Icons.email_outlined, 'inasnuzeer@gmail.com'),
        const SizedBox(height: 30),
        MouseRegion(
          onEnter: (_) => setState(() {
            _isHoveringOnLink = true;
          }),
          onExit: (_) => setState(() {
            _isHoveringOnLink = false;
          }),
          child: InkWell(
            onTap: () => _launchURL('https://www.linkedin.com/inas-nuzeer'),
            child: Row(
              children: [
                Icon(
                  Icons.linked_camera_outlined,
                  size: 20,
                  color: Color(0xFFfeb800),
                ),
                const SizedBox(width: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'linkedin.com/inas-nuzeer',
                    style: TextStyle(
                      color: _isHoveringOnLink
                          ? Color(0xFFfeb800)
                          : Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _personalData2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _personalDataCard(Icons.phone_android_outlined, '+94 76 418 9477'),
        const SizedBox(height: 30),
        _personalDataCard(Icons.map_outlined, 'Mawanella, Sri Lanka'),
      ],
    );
  }

  Widget _personalDataCard(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFFfeb800)),
        const SizedBox(width: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
