import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/button/basic_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chooseModeBG),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.250)),
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
                    'Choose Mode',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.grey.withValues(alpha: 0.5),
                                ),
                                child: SvgPicture.asset(
                                  AppVectors.sun,
                                  fit: BoxFit.none,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white, 
                                    BlendMode.srcIn
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Light Mode',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 17, 
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 40),
                      Column(
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.grey.withValues(alpha: 0.5),
                                ),
                                child: SvgPicture.asset(
                                  AppVectors.moon,
                                  fit: BoxFit.none,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white, 
                                    BlendMode.srcIn
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Dark Mode',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 17, 
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  BasicButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChooseModePage())
                    );
                  }, title: "Continue", height: 60)
                ],
              ),
           ),
        ],
      ),
    );
  }
}