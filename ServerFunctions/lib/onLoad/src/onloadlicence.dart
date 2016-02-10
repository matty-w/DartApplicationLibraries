library onLoadLicence;

import 'dart:html';
import 'dart:js';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class OnLoadLicence
{
  void setDefaultIpAddress(String ipAddressBoxId)
  {
    InputElement ipAddress = querySelector(ipAddressBoxId);
    ipAddress.value = window.location.host;
  }
}