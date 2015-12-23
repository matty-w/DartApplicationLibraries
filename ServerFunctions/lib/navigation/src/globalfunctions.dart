library globalFunctions;

import 'dart:html';
import 'dart:js';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'navigationfunctions.dart'; 

class GlobalFunctions
{
  void setLogOut()
  {
    NavigationFunctions navigate = new NavigationFunctions();
    querySelector("#showLogOut").onClick.listen(navigate.logoutLicence);
  }
  
  void setDefaultIpAddress()
  {
    InputElement ipAddress = querySelector("#url");
    ipAddress.value = window.location.host;
  }
  
  void saveToClipboard(MouseEvent e)
  {
    clipboardPrompt(window.sessionStorage['licenceName']);
  }
  
  void clipboardPrompt(String licence)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    var result = context.callMethod('prompt', ["Copy to clipboard: Ctrl+C, Enter", licence]);
    print(result);
    ps.licenceClipboardPopup("Add-Licence");
    pc.dismiss("#popUpDiv");
  }
  
  void clearTable(Event e)
  {
    TableElement table = querySelector("#searchTable");
    table.hidden = true;
  }
  
  void checkForLoggedInUser(Event e)
  {
    if(window.sessionStorage['username'] == "" || window.sessionStorage['username'] == null || 
       window.sessionStorage['password'] == "" || window.sessionStorage['password'] == null)
    {
      window.sessionStorage['username'] = "";
      window.sessionStorage['password'] = "";
      window.location.href = "index.html";
    }
  }
}