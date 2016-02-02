library removeAdminFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class RemoveAdminFunctions
{
  void removeUser(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement username = querySelector("#username");
    String userValue;
    userValue = username.value;
    
    if(userValue == null || userValue.trim() == "")
    {
      ps.errorPrompt("No-Username");
      return;
    }
    
    LicenceServerRequests.removeLicenceUser(userValue, window.sessionStorage['username'],window.sessionStorage['password'],
                             LicenceServerRequests.defaultUri(), 
                             (s) => pc.getResult(ps.licenceSuccessPrompt("Remove-Admin"), s),
                             (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
    
    username.value = "";
  }
}