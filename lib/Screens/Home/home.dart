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

    final bool isMobileScreen = screenWidth < 600;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            SizedBox(height: screenHeight * .04),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              // height: screenHeight,
              // color: Colors.white.withOpacity(.5),
              child: Column(
                mainAxisAlignment: isMobileScreen
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
                crossAxisAlignment: isMobileScreen
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Software Developer · Flutter | Laravel',
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
                        _personalData1(isMobileScreen),
                        const SizedBox(height: 10),
                        _personalData2(isMobileScreen),
                        SizedBox(height: screenHeight * .12),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _personalData1(false)),
                        const SizedBox(width: 30),
                        Expanded(flex: 3, child: _personalData2(false)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            // if (isMobileScreen) ...[
            //   Positioned(
            //     bottom: 0,
            //     left: 0,
            //     right: 0,
            //     child: Image(
            //       image: AssetImage('assets/images/black_layer.png'),
            //     ),
            //   ),
            // ],
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
                            Icons.brightness_1,
                            size: 13,
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
      ),
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

  Widget _personalData1(bool isMobileScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _personalDataCard(Icons.email_outlined, 'inasnuzeer@gmail.com'),
        SizedBox(height: isMobileScreen ? 10 : 30),
        MouseRegion(
          onEnter: (_) => setState(() {
            _isHoveringOnLink = true;
          }),
          onExit: (_) => setState(() {
            _isHoveringOnLink = false;
          }),
          child: InkWell(
            onTap: () => _launchURL(
              'https://www.linkedin.com/in/inas-nuzeer-22b709202?utm_sourse=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
            ),
            child: Row(
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       width: 1,
                //       color: AppTheme.lightTheme.primaryColor,
                //     ),
                //   ),
                //   child:
                Image.asset(
                  'assets/icons/linkedin_16.png',
                  width: 20,
                  height: 20,
                  // errorBuilder: (_, __, ___) =>
                  //     Icon(Icons.link, size: 20, color: Color(0xFFfeb800)),
                ),
                // ),
                const SizedBox(width: 8),
                Text(
                  'linkedin.com/inas-nuzeer',
                  style: TextStyle(
                    color: _isHoveringOnLink ? Color(0xFFfeb800) : Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _personalData2(bool isMobileScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _personalDataCard(Icons.phone_android_outlined, '+94 76 418 9477'),
        SizedBox(height: isMobileScreen ? 10 : 30),
        _personalDataCard(Icons.map_outlined, 'Mawanella, Sri Lanka'),
      ],
    );
  }

  Widget _personalDataCard(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFFfeb800)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
