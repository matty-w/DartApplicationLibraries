library navigation;

import 'dart:html';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class NavigationFunctions
{
  StringBuffer buffer = new StringBuffer();
  Storage local = window.sessionStorage;
  Storage saveProject = window.localStorage;
  HttpRequest request;
  PopupSelection ps = new PopupSelection();
 
  void goToRegistryHomePage(MouseEvent m)
  {
    window.location.href = "registrymain.html";
  }
  
  void reloadPage(MouseEvent m)
  {
    window.location.reload();
  }
  
  void goToRegistryPage()
  {
    window.location.href = "registrymain.html";
  }
  
  void goToIndexPage()
  {
    window.location.href = "index.html";
  } 
    
  void loginRegistry(MouseEvent m)
  {
    InputElement username = querySelector("#usernameTextbox");
    InputElement password = querySelector("#passwordTextbox");
    local['username'] = username.value;
    local['password'] = password.value;
    
    if(username.value == null || username.value.trim() == "")
    {
      ps.errorPrompt("No-Username");
      return;
    }
    if(password.value == null || password.value.trim() == "")
    {
      ps.errorPrompt("No-Password");
      return;
    }
    ServerRequest.basicAuthLogin(username.value, password.value, ServerRequest.defaultUri(), (s) => goToRegistryPage(),
                                (s) => presentErrorPopup());
  }
  
  void logoutRegistry(MouseEvent m)
  {
    TableElement table = querySelector("#registryTable");
    SelectElement select = querySelector("#projectDropDown");
    table.innerHtml = "";
    select.innerHtml = "";
    local['username'] = "";
    local['password'] = "";
    local['project'] = "";
    window.location.href = "index.html";
  }
  
  void presentErrorPopup()
  {
    local['username'] = "";
    local['password'] = "";
    ps.errorPrompt("Incorrect-Details");
  }
  
  void loginLicence(MouseEvent m)
  {
    InputElement username = querySelector("#usernameTextbox");
    InputElement password = querySelector("#passwordTextbox");
    
    if(username.value.trim() == "" || username.value == null)
    {
      ps.errorPrompt("No-Username");
      return;
    }
    if(password.value.trim() == "" || password.value == null)
    {
      ps.errorPrompt("No-Password");
      return;
    }
    
    ServerRequest.checkPermissions(username.value,password.value,ServerRequest.defaultUri(),storePermissions);
    checkDetails(username.value, password.value);
  }
  
  void logoutLicence(MouseEvent m)
  {
    Storage local = window.sessionStorage;
    local['username'] = "";
    local['password'] = "";
    local['permissions'] = "";
    window.location.href = "index.html";
  }
  
  void goToLicencePage()
  {
    InputElement username = querySelector("#usernameTextbox");
    InputElement password = querySelector("#passwordTextbox");
    Storage local = window.sessionStorage;
    String page = "";
    List<String> permissions = new List<String>();
    String response = local['permissions'];
    if(response != null || response.trim() != "")
    {
      permissions = response.split(",");
    }  
    if(permissions.contains("add-licence"))
    {  
      page = "createLicence.html";
    }    
    if ((permissions!=null)&&(!permissions.contains('add-licence')))
    { 
      page = "changePassword.html";
    }    
    local['username'] = username.value;
    local['password'] = password.value;
    window.location.href = page;
  }
  
  void checkDetails(String userName, String password)
  {  
    ServerRequest.licenceAdminLogin(userName, password, ServerRequest.defaultUri(),
        () => goToLicencePage(),
        () => ps.errorPrompt("Incorrect-Details"));
  }

  void storePermissions(String response)
  {
    Storage local = window.sessionStorage;
    local['permissions'] = response;
  }
}