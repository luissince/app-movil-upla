import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color.fromRGBO(0, 125, 188, 1);
const kPrimaryLightColor = Color.fromARGB(255, 232, 248, 255);
const kDartLightColor = Color(0x7f04000a);

const apiUrl = "https://services.upla.edu.pe";

const apiUplaEduPe = "https://api.upla.edu.pe";

const urlGoogle = "https://www.google.com/";

const apiWebSocket = "http://172.16.2.32:5000";

const abecedario = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
];

const listMonth = [
  "ENE",
  "FEB",
  "MAR",
  "ABR",
  "MAY",
  "JUN",
  "JUL",
  "AGO",
  "SET",
  "OCT",
  "NOV",
  "DIC"
];

const listWeekdays = [
  "lunes",
  "martes",
  "miercoles",
  "jueves",
  "viernes",
  "sabado",
  "domingo"
];

const listCiclos = [
  "PRIMER CICLO",
  "SEGUNDO CICLO",
  "TERCER CICLO",
  "CUARTO CICLO",
  "QUINTO CICLO",
  "SEXTO CICLO",
  "SEPTIMO CICLO",
  "OCTAVO CICLO",
  "NOVENO CICLO",
  "DECIMO CICLO",
  "ONCEAVO CICLO",
  "DOCEAVO CICLO"
];

String nullToString(var value) {
  return value ?? "";
}

int nullToInt(var value) {
  return value ?? 0;
}

double nullToDouble(var value) {
  return value ?? 0;
}

bool nullToBoolean(var value) {
  return value ?? false;
}

String formatDate(String value) {
  try {
    DateTime date = DateTime.parse(value);
    return DateFormat("dd/MM/yyyy").format(date);
  } catch (error) {
    return value;
  }
}

String formatHour(String value) {
  try {
    return DateFormat.jm().format(DateFormat("hh:mm:ss").parse("$value:00"));
  } catch (error) {
    return value;
  }
}
