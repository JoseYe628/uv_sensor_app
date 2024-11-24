
import 'package:flutter/material.dart';

class _SkinInfo {
  final String name;
  final String description;
  final String sunburn; // quemadura
  final String tan; // bronceado
  final Map<String, String> meds;
  final Color color;

  _SkinInfo({required this.name, required this.description, required this.sunburn, required this.tan, required this.meds, required this.color}); // Tiempos de quemadura sin protección
}

var skin_info = {
  "i": _SkinInfo(
    name: "Piel muy clara",
    description: "La piel es extremadamente pálida, de tono lechoso o rosado, a menudo con pecas visibles.",
    sunburn: "Siempre se quema",
    tan: "Nunca se broncea",
    color: const Color(0xfffadcc4),
    meds: {
      "menos de 2": "Se quema en más de 1 hora",
      "de 2 a 5": "Se quema en 40 minutos",
      "de 5 a 9": "Se quema en 25 minutos",
      "de 9 a 12": "Se quema en 15 a 20 minutos",
      "de 12 a 14": "Se quema en 10 a 15 minutos",
      "más de 14": "Se quema en menos de 10 minutos"
    }
  ),
  "ii": _SkinInfo(
    name: "Piel clara",
    description: "La piel es clara, con un tono beige o rosado suave, frecuentemente uniforme y delicada",
    sunburn: "Se quema con mucha facilidad",
    tan: "El bronceado es mínimo",
    color: const Color(0xfff1c5a2),
    meds: {
      "menos de 2": "Se quema en más de 1 hora",
      "de 2 a 5": "Se quema en 40 minutos",
      "de 5 a 9": "Se quema en 25 minutos",
      "de 9 a 12": "Se quema en 15 a 20 minutos",
      "de 12 a 14": "Se quema en 10 a 15 minutos",
      "más de 14": "Se quema en menos de 10 minutos"
    }
  ),
  "iii": _SkinInfo(
    name: "Piel clara intermedia",
    description: "La piel es de tono beige más oscuro o dorado, con una apariencia ligeramente cálida.",
    sunburn: "Se quema con facilidad",
    tan: "El bronceado es gradual, intermedio",
    color: const Color(0xfffdb28b),
    meds: {
      "menos de 2": "Se quema en más de 1 hora",
      "de 2 a 5": "Se quema en más de 1 hora",
      "de 5 a 9": "Se quema en 40 minutos",
      "de 9 a 12": "Se quema en 25 a 30 minutos",
      "de 12 a 14": "Se quema en 10 a 20 minutos",
      "más de 14": "Se quema en menos de 15 minutos"
    }
  ),
  "iv": _SkinInfo(
    name: "Piel oliva",
    description: "La piel tiene un tono oliváceo o marrón claro, generalmente de aspecto uniforme y cálido.",
    sunburn: "Se quema ocacionalmente",
    tan: "Sí se presenta bronceado",
    color: const Color(0xffe08c72),
    meds: {
      "menos de 2": "Se quema en más de 1 hora",
      "de 2 a 5": "Se quema en más de 1 hora",
      "de 5 a 9": "Se quema en 40 minutos",
      "de 9 a 12": "Se quema en 25 a 30 minutos",
      "de 12 a 14": "Se quema en 10 a 20 minutos",
      "más de 14": "Se quema en menos de 15 minutos"
    }
  ),
  "v": _SkinInfo(
    name: "Piel oscura",
    description: "La piel es marrón profundo, con un tono rico e intenso, a menudo cálido y vibrante.",
    sunburn: "Muy raramente se quema",
    tan: "El bronceado es intenso",
    color: const Color(0xff9b615d),
    meds: {
      "menos de 2": "Se quema en más de 1 hora",
      "de 2 a 5": "Se quema en más de 1 hora",
      "de 5 a 9": "Se quema en 50 minutos",
      "de 9 a 12": "Se quema en 35 a 40 minutos",
      "de 12 a 14": "Se quema en 20 a 30 minutos",
      "más de 14": "Se quema en menos de 20 minutos"
    }
  ),
  "vi": _SkinInfo(
    name: "Piel muy oscura",
    description: "La piel es marrón muy oscuro o negra, de un tono profundo y naturalmente brillante.",
    sunburn: "Nunca se quema",
    tan: "El bronceado es máximo",
    color: const Color(0xff64413d),
    meds: {
      "menos de 2": "Se quema en más de 1 hora",
      "de 2 a 5": "Se quema en más de 1 hora",
      "de 5 a 9": "Se quema en 50 minutos",
      "de 9 a 12": "Se quema en 35 a 40 minutos",
      "de 12 a 14": "Se quema en 20 a 30 minutos",
      "más de 14": "Se quema en menos de 20 minutos"
    }
  ),
};


