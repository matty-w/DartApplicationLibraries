library globalNavigationFunctions;

import 'dart:html';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class GlobalNavigationFunctions
{
  Storage local = window.sessionStorage;
  PopupSelection ps = new PopupSelection();
  ProjectNavigation pn = new ProjectNavigation();
  RegistryNavigation rn = new RegistryNavigation();
  
  void basicAuthenticationLogin(String usernameBoxId, String passwordBoxId, String applicationLogin)
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
    if(applicationLogin == "Project-Application")
    {
      PortfolioServerRequests.basicAuthLogin(username.value, password.value, PortfolioServerRequests.defaultUri(), 
                                            (s) => pn.goToPageProject("addProject"),
                                            (s) => presentLoginErrorPopup());
    }
    else if(applicationLogin == "Registry-Application")
    {
      PortfolioServerRequests.basicAuthLogin(username.value, password.value, PortfolioServerRequests.defaultUri(), 
                                            (s) => rn.goToPageRegistry("registryMain"),
                                            (s) => presentLoginErrorPopup());
    }
  }
  
  void loginLicenceApplication(String usernameBoxId, String passwordBoxId)
  {
    InputElement username = querySelector(usernameBoxId);
    InputElement password = querySelector(passwordBoxId);
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
  
  void reloadPage(MouseEvent m)
  {
    window.location.reload();
  }
  
  void presentLoginErrorPopup()
  {
    local['username'] = "";
    local['password'] = "";
    ps.errorPrompt("Incorrect-Details");
  }
  
  void checkForLoggedInUser(String usernameStorageId, String passwordStorageId)
  {
    if(window.sessionStorage[usernameStorageId] == "" || window.sessionStorage[usernameStorageId] == null || 
       window.sessionStorage[passwordStorageId] == "" || window.sessionStorage[passwordStorageId] == null)
    {
      window.sessionStorage['username'] = "";
      window.sessionStorage['password'] = "";
      window.location.href = "index.html";
    }
  }
}