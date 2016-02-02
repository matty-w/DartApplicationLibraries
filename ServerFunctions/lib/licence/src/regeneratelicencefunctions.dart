library regenerateLicenceFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class RegenerateLicenceFunctions
{
  void regenerateLicence(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement usernameInput = querySelector("#username");
    InputElement url = querySelector("#url");
    
    String userValue;
    
    if(usernameInput.value == null || usernameInput.value.trim() == "")
    {
      ps.errorPrompt("No-Licence-Name");
      return;
    }  
    
    userValue = usernameInput.value;
      if (url.value.length>0)
        userValue = userValue+"("+url.value+")";
      
      
      
    LicenceServerRequests.regenerateLicence(userValue, window.sessionStorage['username'],
                                    window.sessionStorage['password'], LicenceServerRequests.defaultUri(), 
                                    (s) => pc.getResult(ps.licenceSuccessPrompt("Regenerate-Licence"), s),
                                    (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));  
  }
}