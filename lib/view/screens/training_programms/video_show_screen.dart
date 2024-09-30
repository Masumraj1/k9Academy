import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/view/screens/home_screen/model/training_details.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoShowScreen extends StatefulWidget {
  const VideoShowScreen({super.key});

  @override
  State<VideoShowScreen> createState() => _VideoShowScreenState();
}

class _VideoShowScreenState extends State<VideoShowScreen> {
  final TrainingDetailsDatum data = Get.arguments;

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  bool _isVideoInitialized = false;

  Future<void> videoInit() async {
    try {
      final videoUrl = "${ApiUrl.baseUrl}/${data.video}";

      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoPlayerController.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );

      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      debugPrint("Error initializing video: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    videoInit();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackyDarkHover,
      appBar: AppBar(
        backgroundColor: AppColors.blackyDarker,
        title: CustomText(
          text: data.articleTitle ?? "",
          fontSize: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///============================== Video Player =========================
            if (_isVideoInitialized)
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: double.maxFinite,
                child: Chewie(
                  controller: chewieController!,
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            SizedBox(
              height: 10.w,
            ),

            ///====================================Text Design==========================
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppColors.blackyDarker,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: data.articleName ?? "",
                    color: AppColors.lightNormal,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    bottom: 15,
                  ),
                  CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 40,
                    text: data.articleDescription ?? "",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
