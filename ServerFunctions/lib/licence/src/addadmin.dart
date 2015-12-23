library addADminFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddAdminFunctions
{
  void addAdmin(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement userNameInput = querySelector("#username");
    InputElement passwordInput = querySelector("#password");
    InputElement confirmPassword = querySelector("#confirmPassword");
    String passwordFirst = passwordInput.value;
    String passwordSecond = confirmPassword.value;
    
    if(userNameInput.value == null || userNameInput.value.trim() == "")
    {
      ps.errorPrompt("No-Username");
      return;
    }
    
    if(passwordFirst == null || passwordFirst.trim() == "" || passwordSecond == null || passwordSecond.trim() == "")
    {  
      ps.errorPrompt("No-Password");
      return;
    }  
    
    if(checkPasswordsMatch(passwordFirst, passwordSecond) == true)
    { 
      String user = userNameInput.value;
      String password = passwordInput.value;
       
      ServerRequest.addAdminUser(user, password, window.sessionStorage['username'],window.sessionStorage['password'],
                                 ServerRequest.defaultUri(), (s) => pc.getResult(ps.licenceSuccessPrompt("Add-Admin"), s),
                                 (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
      
      userNameInput.value = "";
      passwordInput.value = "";
      confirmPassword.value = "";
      return;
    }  
      
    ps.errorPrompt("Passwords-Dont-Match");
  }
  
  bool checkPasswordsMatch(String password, String confirmPassword)
  {  
    if(confirmPassword != password)
      return false;
    else
      return true;
  }
}  
