library licenceNavigation;

import 'dart:html';
import 'dart:js';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class LicenceNavigation
{ 
  void setLogOut(String logOutButtonId)
  {
    querySelector(logOutButtonId).onClick.listen(logoutLicence);
  }
  
  void logoutLicence(MouseEvent m)
  {
    Storage local = window.sessionStorage;
    local['username'] = "";
    local['password'] = "";
    local['permissions'] = "";
    window.location.href = "index.html";
  }
}