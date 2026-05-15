import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/button/basic_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presantation/choose_mode/page/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.introBG),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.250)),
           Padding(
             padding: const EdgeInsets.symmetric(
              vertical: 50, 
              horizontal: 50
             ),
             child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.spotifyLogo),
                  ),
                  const Spacer(),
                  Text(
                    'Millions of songs. Free on Spotify.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 21),
                  Text(
                    'Join millions of listeners and creators. From the hits you love to the underground tracks you’ve yet to find, everything you need to hear is right here.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18, 
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  BasicButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChooseModePage())
                    );
                  }, title: "Get Started", height: 60)
                ],
              ),
           ),
        ],
      ),
    );
  }
}
