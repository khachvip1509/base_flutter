import 'package:flutter/material.dart';

enum CardInfo {
  camera('Bài 1:chữ nihongo', Icons.video_call, Color(0xff2354C7), Color(0xffECEFFD)),
  lighting('Bài 2: Âm đục', Icons.lightbulb, Color(0xff806C2A), Color(0xffFAEEDF)),
  climate('Bài 3: Âm bn đục', Icons.thermostat, Color(0xffA44D2A), Color(0xffFAEDE7)),
  wifi('Bài 4: Giao tiếp cơ bản', Icons.wifi, Color(0xff417345), Color(0xffE5F4E0)),
  media('Bài 5: Giao tiếp nâng cao', Icons.library_music, Color(0xff2556C8), Color(0xffECEFFD)),
  security(
    'Bài 6: Giao tiếp trong công việc',
    Icons.crisis_alert,
    Color(0xff794C01),
    Color(0xffFAEEDF),
  ),
  safety(
    'Bài 7: Giao tiếp khi đi du lịch',
    Icons.medical_services,
    Color(0xff2251C5),
    Color(0xffECEFFD),
  ),
  more('', Icons.add, Color(0xff201D1C), Color(0xffE3DFD8));

  const CardInfo(this.label, this.icon, this.color, this.backgroundColor);

  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
}
