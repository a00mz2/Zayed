// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:zayed/core/constant/assets/lottie.dart';

enum MediaType { image, video }

class MediaInput extends StatefulWidget {
  final Uint8List? localData;
  final String? urlPath;
  final MediaType? type;
  final Function(Uint8List data, MediaType type) onMediaPicked;
  final double? height;
  final double? width;

  const MediaInput({
    super.key,
    this.localData,
    this.urlPath,
    this.type,
    required this.onMediaPicked,
    this.height,
    this.width,
  });

  @override
  State<MediaInput> createState() => _MediaInputState();
}

class _MediaInputState extends State<MediaInput> {
  VideoPlayerController? _videoController;
  bool _isVideoLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  @override
  void didUpdateWidget(MediaInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // إذا تغير الرابط من السيرفر ولم يكن هناك بيانات محلية جديدة، نعيد التحميل
    if (widget.urlPath != oldWidget.urlPath && widget.localData == null) {
      _initializeMedia();
    }
  }

  void _initializeMedia() {
    // تشغيل الفيديو القادم من السيرفر فقط إذا لم يتم اختيار فيديو محلي
    if (widget.type == MediaType.video &&
        widget.urlPath != null &&
        widget.localData == null) {
      _setupNetworkVideo();
    }
  }

  void _setupNetworkVideo() {
    _videoController?.dispose();
    _videoController = null;

    setState(() => _isVideoLoading = true);
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.urlPath!))
          ..initialize()
              .then((_) {
                if (!mounted) return;
                setState(() {
                  _isVideoLoading = false;
                  _videoController!.setLooping(true);
                  _videoController!.setVolume(0);
                  _videoController!.play();
                });
              })
              .catchError((error) {
                debugPrint("Video Error: $error");
                if (mounted) setState(() => _isVideoLoading = false);
              });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _pickMedia() async {
    final ImagePicker picker = ImagePicker();

    final source = await showModalBottomSheet<MediaType>(
      context: context,
      builder: (context) => SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("صورة"),
              onTap: () => Navigator.pop(context, MediaType.image),
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text("فيديو"),
              onTap: () => Navigator.pop(context, MediaType.video),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    XFile? pickedFile;
    if (source == MediaType.image) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      // إذا كان المختار فيديو، نجهزه أولاً داخلياً قبل تحديث الكنترولر الخارجي
      if (source == MediaType.video) {
        setState(() => _isVideoLoading = true);

        // إنشاء كنترولر جديد للملف المختار
        final newController = VideoPlayerController.file(File(pickedFile.path));

        try {
          await newController.initialize();
          _videoController?.dispose(); // التخلص من المشغل القديم
          _videoController = newController;
          _videoController!.setLooping(true);
          _videoController!.play();
        } catch (e) {
          debugPrint("Error initializing local video: $e");
        }

        if (mounted) setState(() => _isVideoLoading = false);
      } else {
        // إذا اختار صورة، نحذف أي مشغل فيديو موجود
        _videoController?.dispose();
        _videoController = null;
      }

      // أخيراً نرسل البيانات والنوع للـ Controller الخارجي
      final data = await pickedFile.readAsBytes();
      widget.onMediaPicked(data, source);

      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickMedia,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 150,
        color: Colors.grey.withOpacity(0.1),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    // 1. حالة التحميل
    if (_isVideoLoading) {
      return Center(
        child: Lottie.asset(
          AppLottie.lodingcover,
          fit: BoxFit
              .fill, // سيقوم بمط الصورة لتملأ الارتفاع والعرض المحددين بالضبط
          width: double.infinity,
        ),
      );
    }

    // 2. عرض الفيديو (محلي أو سيرفر) إذا تم تهيئته
    if (_videoController != null && _videoController!.value.isInitialized) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: _videoController!.value.size.width,
            height: _videoController!.value.size.height,
            child: VideoPlayer(_videoController!),
          ),
        ),
      );
    }

    // 3. عرض الصورة المحلية (المرفوعة للتو)
    if (widget.localData != null && widget.type == MediaType.image) {
      return SizedBox.expand(
        child: Image.memory(widget.localData!, fit: BoxFit.cover),
      );
    }

    // 4. عرض الصورة من السيرفر
    if (widget.urlPath != null && widget.type == MediaType.image) {
      return SizedBox.expand(
        child: Image.network(
          widget.urlPath!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, lp) => lp == null
              ? child
              : const Center(child: CircularProgressIndicator()),
          errorBuilder: (c, e, s) =>
              const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    }

    // 5. حالة الفراغ
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 20,
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
        // Image.asset(AppIcons.camera, width: 40, height: 40, color: Colors.grey),
        SizedBox(height: 6),
        Text("لا يوجد غلاف", style: Theme.of(context).textTheme.bodyMedium!),
        SizedBox(height: 0),
        Text(
          "انقر لاضافة صورة او فيديو",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
