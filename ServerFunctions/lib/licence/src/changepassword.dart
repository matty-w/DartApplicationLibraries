library changePasswordFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class ChangePassword
{
  void changePassword(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement username = querySelector("#username");
    InputElement password = querySelector("#password");
    InputElement confirmPassword = querySelector("#confirmPassword");
    String pass = password.value;
    String cp = confirmPassword.value;
    
    if(pass == null || pass.trim() == "" || cp == null || cp.trim() == "")
    {
      ps.errorPrompt("No-Password");
      return;
    }
    
    if(pass != cp)
    {
      ps.errorPrompt("Passwords-Dont-Match");
      return;
    }
    else
    {
      LicenceServerRequests.changeAdminPassword(username.value, cp, window.sessionStorage['username'],
                                                window.sessionStorage['password'],LicenceServerRequests.defaultUri(), 
                                                (s) => pc.getResult(ps.licenceSuccessPrompt("Change-Password"), s),
                                                (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
      window.sessionStorage['password'] = pass;
    }  
    
    pass = "";
    cp = "";
  }
}