library projectNavigation;

import 'dart:html';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class ProjectNavigation
{
  Storage local = window.sessionStorage;
  
  void goToPageProject(String pageDestination)
  {
    if(pageDestination == "indexPage")
      window.location.href = "index.html";
    if(pageDestination == "addProject")
      window.location.href = "addproject.html";
    if(pageDestination == "editProject")
      window.location.href = "editproject.html";
    if(pageDestination == "deleteProject")
      window.location.href = "deleteproject.html";
    if(pageDestination == "addUsers")
      window.location.href = "addusers.html";
    if(pageDestination == "secureProject")
      window.location.href = "secureproject.html";
    if(pageDestination == "addFolder")
      window.location.href = "addfolders.html";
    if(pageDestination == "tagProject")
      window.location.href = "tagfolders.html";
  }
  
  void logoutProject(MouseEvent m)
  {
    local['username'] = "";
    local['password'] = "";
    window.location.href = "index.html";
  }
}