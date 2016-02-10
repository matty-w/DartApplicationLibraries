library registryNavigation;

import 'dart:html';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class RegistryNavigation
{
  Storage local = window.sessionStorage;
  
  void goToPageRegistry(String pageDestination)
  {
    if(pageDestination == "registryMain")
      window.location.href = "registrymain.html";
    if(pageDestination == "indexPage")
      window.location.href = "index.html";
  }
  
  void logoutRegistry(String tableId, String projectDropdownId)
  {
    TableElement table = querySelector(tableId);
    SelectElement select = querySelector(projectDropdownId);
    table.innerHtml = "";
    select.innerHtml = "";
    local['username'] = "";
    local['password'] = "";
    local['project'] = "";
    window.location.href = "index.html";
  }
}