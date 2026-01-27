import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:zayed/core/constant/assets/lottie.dart';

enum MediaType { image, video }

class ViewerImageWidget extends StatelessWidget {
  const ViewerImageWidget({
    super.key,
    this.url,
    required this.width,
    required this.height,
    this.errorIcon,
    this.lodingIcon,
    this.circular = 16,
    this.fit = BoxFit.cover,
    this.lottieLoding = true,

    // ✅ جديد: تحديد النوع (افتراضي صورة)
    this.type = MediaType.image,
    // ✅ جديد: هل الفيديو يشتغل تلقائي + لوب
    this.autoPlayVideo = true,
    this.loopVideo = true,
    this.muteVideo = true,
  });

  final String? url;
  final double width, height;
  final Widget? errorIcon;
  final Widget? lodingIcon;
  final double? circular;
  final BoxFit? fit;
  final bool? lottieLoding;

  // ✅ جديد
  final MediaType type;
  final bool autoPlayVideo;
  final bool loopVideo;
  final bool muteVideo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circular!),
      child: type == MediaType.video
          ? _VideoNetworkWidget(
        url: url ?? "",
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorIcon: errorIcon,
        lodingIcon: lodingIcon,
        lottieLoding: lottieLoding ?? true,
        autoPlay: autoPlayVideo,
        loop: loopVideo,
        mute: muteVideo,
      )
          : CachedNetworkImage(
        imageUrl: url ?? "",
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              lottieLoding!
                  ? Lottie.asset(
                AppLottie.lodingImage,
                fit: BoxFit.cover,
                width: width,
                height: height,
              )
                  : Container(
                width: width,
                height: height,
                color: const Color(0xffF0F0F0),
              ),
              Center(child: lodingIcon ?? const SizedBox()),
            ],
          ),
        ),
        errorWidget: (context, url, error) => Stack(
          children: [
            Container(
                width: width,
                height: height,
                color: const Color(0xffF0F0F0)),
            Center(child: errorIcon ?? const SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _VideoNetworkWidget extends StatefulWidget {
  const _VideoNetworkWidget({
    required this.url,
    required this.width,
    required this.height,
    required this.fit,
    required this.errorIcon,
    required this.lodingIcon,
    required this.lottieLoding,
    required this.autoPlay,
    required this.loop,
    required this.mute,
  });

  final String url;
  final double width, height;
  final BoxFit fit;
  final Widget? errorIcon;
  final Widget? lodingIcon;
  final bool lottieLoding;
  final bool autoPlay;
  final bool loop;
  final bool mute;

  @override
  State<_VideoNetworkWidget> createState() => _VideoNetworkWidgetState();
}

class _VideoNetworkWidgetState extends State<_VideoNetworkWidget> {
  VideoPlayerController? _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    if (widget.url.trim().isEmpty) {
      setState(() => _hasError = true);
      return;
    }

    try {
      final c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      _controller = c;

      await c.initialize();

      if (widget.mute) {
        await c.setVolume(0);
      }
      await c.setLooping(widget.loop);

      if (widget.autoPlay) {
        await c.play();
      }

      if (mounted) setState(() {});
    } catch (_) {
      if (mounted) setState(() => _hasError = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Stack(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            color: const Color(0xffF0F0F0),
          ),
          Center(child: widget.errorIcon ?? const SizedBox()),
        ],
      );
    }

    final c = _controller;

    // ✅ إذا الكنترولر null أو غير مهيأ -> placeholder
    if (c == null || !c.value.isInitialized) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            widget.lottieLoding
                ? Lottie.asset(
              AppLottie.lodingImage,
              fit: BoxFit.cover,
              width: widget.width,
              height: widget.height,
            )
                : Container(
              width: widget.width,
              height: widget.height,
              color: const Color(0xffF0F0F0),
            ),
            Center(child: widget.lodingIcon ?? const SizedBox()),
          ],
        ),
      );
    }

    // ✅ جاهز: اعرضه cover داخل حجم ثابت
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRect(
        child: FittedBox(
          fit: widget.fit, // BoxFit.cover
          child: SizedBox(
            width: c.value.size.width,
            height: c.value.size.height,
            child: VideoPlayer(c),
          ),
        ),
      ),
    );
  }

}
