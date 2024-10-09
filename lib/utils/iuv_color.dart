
import 'package:flutter/material.dart';

Color getColorForUVIndex(int iuv) {
  // Definimos los colores del semáforo UV
  const lowUVColor = Colors.green;
  const moderateUVColor = Colors.yellow;
  const highUVColor = Colors.orange;
  const veryHighUVColor = Colors.red;
  const extremeUVColor = Colors.purple;
  const fullUVColor = Colors.lightBlue;

  if (iuv <= 2) {
    // Índice UV bajo (0-2), color verde
    return lowUVColor;
  } else if (iuv <= 5) {
    // Índice UV moderado (3-5), interpolar entre verde y amarillo
    return Color.lerp(lowUVColor, moderateUVColor, (iuv - 2) / 3)!;
  } else if (iuv <= 7) {
    // Índice UV alto (6-7), interpolar entre amarillo y naranja
    return Color.lerp(moderateUVColor, highUVColor, (iuv - 5) / 2)!;
  } else if (iuv <= 10) {
    // Índice UV muy alto (8-10), interpolar entre naranja y rojo
    return Color.lerp(highUVColor, veryHighUVColor, (iuv - 7) / 3)!;
  } else if(iuv <= 17) {
    // Índice UV extremo (9-17), interpolar entre rojo y púrpura
    return Color.lerp(veryHighUVColor, extremeUVColor, (iuv - 10) / 9)!;
  } else {
    return Color.lerp(extremeUVColor, fullUVColor, (iuv - 10) / 3)!;
  }
}

