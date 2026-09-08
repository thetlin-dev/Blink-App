import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // Camera & Media States
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  bool _isCameraInitialized = false;

  File? _selectedFile;
  bool _isVideo = false;

  // Controls States
  bool _isFilterOn = false;
  String _selectedSpeed = '1.0x';
  int _timerSeconds = 0;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  // ၁။ Camera Device စတင်မောင်းနှင်ရန်
  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _selectedCameraIndex = 0;
        await _setupCamera(_cameras![_selectedCameraIndex]);
      }
    } catch (e) {
      debugPrint('Camera Init Error: $e');
    }
  }

  Future<void> _setupCamera(CameraDescription camera) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    try {
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera Controller Error: $e');
    }
  }

  // ၂။ Camera Front / Back Flip လုပ်ရန်
  void _toggleCamera() {
    if (_cameras == null || _cameras!.length < 2) return;
    _selectedCameraIndex = (_selectedCameraIndex == 0) ? 1 : 0;
    _setupCamera(_cameras![_selectedCameraIndex]);
  }

  // ၃။ Gallery မှ Photo သို့မဟုတ် Video ရွေးရန်
  Future<void> _pickMedia(bool isVideo) async {
    final XFile? file = isVideo
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _selectedFile = File(file.path);
        _isVideo = isVideo;
      });
    }
  }

  // ရွေးထားသည့် File ကို ပြန်ဖြုတ်ပြီး Camera UI ထံ ပြန်သွားရန်
  void _clearSelectedMedia() {
    setState(() {
      _selectedFile = null;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // --- ၁။ MAIN PREVIEW AREA (Camera သို့မဟုတ် Photo/Video Display) ---
            Positioned.fill(
              child: _selectedFile != null
                  ? (_isVideo
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.video_library,
                                  size: 64, color: Colors.pinkAccent),
                              const SizedBox(height: 12),
                              Text(
                                'Selected Video:\n${_selectedFile!.path.split('/').last}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      : Image.file(_selectedFile!, fit: BoxFit.cover))
                  : (_isCameraInitialized &&
                          _cameraController != null &&
                          _cameraController!.value.isInitialized
                      ? CameraPreview(_cameraController!)
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pinkAccent,
                          ),
                        )),
            ),

            // --- ၂။ TOP CONTROL BAR (Close, Title, Next) ---
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close,
                        color: Colors.white, size: 28),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const Text(
                    'Create Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Proceeding to Post Edit...'),
                        ),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- ၃။ RIGHT SIDE TOOLBAR (Flip, Speed, Filter, Timer) ---
            Positioned(
              top: 80,
              right: 16,
              child: Column(
                children: [
                  _buildSideButton(
                    icon: Icons.flip_camera_ios,
                    label: 'Flip',
                    isActive: false,
                    onTap: _toggleCamera,
                  ),
                  const SizedBox(height: 20),
                  _buildSideButton(
                    icon: Icons.speed,
                    label: _selectedSpeed,
                    isActive: _selectedSpeed != '1.0x',
                    onTap: () {
                      setState(() {
                        if (_selectedSpeed == '1.0x') {
                          _selectedSpeed = '2.0x';
                        } else if (_selectedSpeed == '2.0x') {
                          _selectedSpeed = '0.5x';
                        } else {
                          _selectedSpeed = '1.0x';
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSideButton(
                    icon: Icons.auto_awesome,
                    label: 'Filters',
                    isActive: _isFilterOn,
                    onTap: () {
                      setState(() {
                        _isFilterOn = !_isFilterOn;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSideButton(
                    icon: Icons.timer,
                    label: _timerSeconds > 0 ? '${_timerSeconds}s' : 'Timer',
                    isActive: _timerSeconds > 0,
                    onTap: () {
                      setState(() {
                        if (_timerSeconds == 0) {
                          _timerSeconds = 3;
                        } else if (_timerSeconds == 3) {
                          _timerSeconds = 10;
                        } else {
                          _timerSeconds = 0;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),

            // --- ၄။ BOTTOM BAR (Photo/Video Gallery Pickers & Record Button) ---
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Photo Picker Button
                  IconButton(
                    icon: const Icon(Icons.photo_library,
                        color: Colors.white, size: 32),
                    onPressed: () => _pickMedia(false),
                  ),

                  // Record Button
                  GestureDetector(
                    onTap: () {
                      if (_selectedFile != null) {
                        _clearSelectedMedia();
                      }
                    },
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        color: Colors.pinkAccent,
                      ),
                      child: Icon(
                        _selectedFile != null ? Icons.refresh : Icons.videocam,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),

                  // Video Picker Button
                  IconButton(
                    icon: const Icon(Icons.video_collection,
                        color: Colors.white, size: 32),
                    onPressed: () => _pickMedia(true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Side Control Button UI Helper
  Widget _buildSideButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: isActive ? Colors.pinkAccent : Colors.white,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.pinkAccent : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
