import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class StudentLiveStreamPage extends StatefulWidget {
  final String channelName = "test_channel";
  final String appId = "e852fa884df2463f83c3684bba401896";
  final String token = "007eJxTYHhyiEnLpueB+sTXsSU3+470lDVNbzjtdOAtV5PwJAHuwj4FhlQLU6O0RAsLk5Q0IxMz4zQL42RjMwuTpKREEwNDC0szZ76I9IZARoY9i48yMzJAIIjPw1CSWlwSn5yRmJeXmsPAAABbfiJP";

  StudentLiveStreamPage({Key? key}) : super(key: key);

  @override
  _StudentLiveStreamPageState createState() => _StudentLiveStreamPageState();
}

class _StudentLiveStreamPageState extends State<StudentLiveStreamPage> {
  late final RtcEngine _engine;
  bool isJoined = false;
  bool isMuted = false;
  bool isVideoOff = false;
  bool isFrontCamera = true;
  int? localUid;
  int? remoteUid;
  String meetingLink = '';
  String errorMessage = '';
  final String rtmpUrl = 'rtmp://a.rtmp.youtube.com/live2/YOUR_STREAM_KEY';

  @override
  void initState() {
    super.initState();
    _initAgora();
    meetingLink = "https://yourapp.meet/${widget.channelName}";
  }

  Future<void> _initAgora() async {
    try {
      var status = await [Permission.camera, Permission.microphone].request();
      if (status[Permission.camera] != PermissionStatus.granted ||
          status[Permission.microphone] != PermissionStatus.granted) {
        setState(() {
          errorMessage = 'Camera and Microphone permissions are required.';
        });
        return;
      }

      _engine = createAgoraRtcEngine();
      await _engine.initialize(
        RtcEngineContext(
          appId: widget.appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      _engine.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          setState(() {
            isJoined = true;
            localUid = connection.localUid;
          });
          print('Student joined channel: ${connection.channelId} with UID: ${connection.localUid}');
          _startRtmpStream();
        },
        onUserJoined: (connection, remoteUidParam, elapsed) {
          setState(() {
            remoteUid = remoteUidParam;
          });
          print('User joined: $remoteUidParam');
        },
        onUserOffline: (connection, remoteUidParam, reason) {
          setState(() {
            remoteUid = null;
          });
          print('User offline: $remoteUidParam');
        },
        onError: (errorCode, description) {
          setState(() {
            errorMessage = 'Agora SDK Error: $errorCode, Description: $description';
          });
          print('Agora SDK Error: $errorCode, Description: $description');
        },
      ));

      await _engine.enableVideo();
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

      await _engine.joinChannel(
        token: widget.token,
        channelId: widget.channelName,
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to initialize Agora SDK: $e';
      });
      print('Failed to initialize Agora SDK: $e');
    }
  }

  Future<void> _startRtmpStream() async {
    try {
      LiveTranscoding transcoding = LiveTranscoding(
        width: 1280,
        height: 720,
        videoBitrate: 4000,
        videoFramerate: 30,
        audioSampleRate: AudioSampleRateType.audioSampleRate48000,
        audioBitrate: 128,
        audioChannels: 2,
        videoGop: 30,
        videoCodecProfile: VideoCodecProfileType.videoCodecProfileHigh,
      );

      await _engine.startRtmpStreamWithTranscoding(
        url: rtmpUrl,
        transcoding: transcoding,
      );

      print('RTMP stream started: $rtmpUrl');
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to start RTMP stream: $e';
      });
      print('Failed to start RTMP stream: $e');
    }
  }

  Future<void> _stopRtmpStream() async {
    try {
      await _engine.stopRtmpStream(rtmpUrl);
      print('RTMP stream stopped');
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to stop RTMP stream: $e';
      });
      print('Failed to stop RTMP stream: $e');
    }
  }

  @override
  void dispose() {
    _stopRtmpStream();
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
    _engine.muteLocalAudioStream(isMuted);
  }

  void _toggleVideo() {
    setState(() {
      isVideoOff = !isVideoOff;
    });
    _engine.muteLocalVideoStream(isVideoOff);
  }

  void _switchCamera() {
    _engine.switchCamera();
    setState(() {
      isFrontCamera = !isFrontCamera;
    });
  }

  void _shareLink() {
    Share.share(meetingLink, subject: 'Join my meeting');
  }

  void _endMeeting() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('End Meeting'),
          content: const Text('Are you sure you want to end the meeting?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showFeedbackDialog();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog() {
    String feedbackText = '';
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap Cancel or Post
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feedback'),
          content: TextField(
            onChanged: (value) {
              feedbackText = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your feedback here...',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // User chose to not post feedback but the meeting should still end
                Navigator.of(context).pop();
                _quitMeeting();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the feedback (for example, print or send it to server)
                print('User Feedback: $feedbackText');
                Navigator.of(context).pop();
                _quitMeeting();
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }

  void _quitMeeting() async {
    try {
      await _stopRtmpStream();
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to stop RTMP stream: $e';
      });
      print('Failed to stop RTMP stream: $e');
    }
    await _engine.leaveChannel();
    Navigator.of(context).pop();
  }

  Widget _renderRemoteVideo() {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'Waiting for other participants...',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }
  }

  Widget _renderLocalVideo() {
    if (isVideoOff) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 40,
      right: 20,
      width: 120,
      height: 160,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: localUid != null
            ? AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: 0),
          ),
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _toolbar() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToolbarButton(
                  icon: isMuted ? Icons.mic_off : Icons.mic,
                  color: isMuted ? Colors.white : Colors.blue,
                  backgroundColor: isMuted ? Colors.blue : Colors.white,
                  onPressed: _toggleMute,
                ),
                const SizedBox(width: 10),
                _buildToolbarButton(
                  icon: Icons.call_end,
                  color: Colors.white,
                  backgroundColor: Colors.redAccent,
                  onPressed: _endMeeting,
                  size: 30.0,
                ),
                const SizedBox(width: 10),
                _buildToolbarButton(
                  icon: isVideoOff ? Icons.videocam_off : Icons.videocam,
                  color: isVideoOff ? Colors.white : Colors.blue,
                  backgroundColor: isVideoOff ? Colors.blue : Colors.white,
                  onPressed: _toggleVideo,
                ),
                const SizedBox(width: 10),
                _buildToolbarButton(
                  icon: Icons.switch_camera,
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                  onPressed: _switchCamera,
                ),
                const SizedBox(width: 10),
                _buildToolbarButton(
                  icon: Icons.link,
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                  onPressed: _shareLink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    VoidCallback? onPressed,
    double size = 20.0,
  }) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon, color: color, size: size),
      shape: const CircleBorder(),
      elevation: 2.0,
      fillColor: backgroundColor,
      padding: const EdgeInsets.all(12.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              _renderRemoteVideo(),
              if (errorMessage.isNotEmpty)
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.redAccent,
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              _renderLocalVideo(),
              _toolbar(),
            ],
          );
        },
      ),
    );
  }
}