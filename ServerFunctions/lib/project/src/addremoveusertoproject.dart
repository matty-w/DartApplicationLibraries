library addUserToProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddRemoveUserToProject
{
  int totalPassed = 0;
  int totalFailed = 0;
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  
  void addRemoveUserToProject(String projectBoxId, String usernameBoxId, String permissionBox, String addRemoveBox)
  {
    SelectElement addRemoveUserBox = querySelector(addRemoveBox);
    InputElement userNameBox = querySelector(usernameBoxId);
    SelectElement projectNamebox = querySelector(projectBoxId);
    SelectElement permissionsBox = querySelector(permissionBox);

    String addRemoveUser = addRemoveUserBox.value;
    String user = userNameBox.value;
    String projectName = projectNamebox.value;
    String permissions = permissionsBox.value;
    
    if(userNameBox.value.trim() == "" || userNameBox.value == null)
    {
      ps.errorPrompt("No-Username");      
    }
    
    if(addRemoveUser == "Remove User" && permissions == "No Permissions")
    {
      String scriptCommand = createRemoveUserScriptCommand(user, projectName);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(),
                                                        (s) => ps.projectSuccessPrompt("User-Removed-From-Project", projectName, null), 
                                                        (s) => pc.getResult(ps.errorPrompt("Remove-User-From-Project-Fail"), s));
    }
    else if(addRemoveUser == "Add User" && permissions == "No Permissions")
    {
      String scriptCommand = createAddUserScriptCommand(user, projectName);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(),
                                                        (s) => ps.projectSuccessPrompt("User-Added-To-Project", projectName, null), 
                                                        (s) => pc.getResult(ps.errorPrompt("Add-User-To-Project-Fail"), s));
    }
    else if(addRemoveUser == "Add User" && permissions != "No Permissions")
    {
      String scriptCommand = createAddUserScriptCommand(user, projectName);
      List<String> permissionsScriptCommand = createPermissionScriptCommands(permissions, user, projectName);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(),
                                                        (s) => createUserPermissions(permissionsScriptCommand, projectName), 
                                                        (s) => pc.getResult(ps.errorPrompt("Add-User-To-Project-Fail"), s));
    }
    

    

  }
  
  List createPermissionScriptCommands(String permissions, String userName, String projectName)
  {
    List<String> permissionScripts = new List<String>();
    String read = "grant permission in "+projectName+" for "+userName+" to read";
    String addPermission = "grant permission in "+projectName+" for "+userName+" to add-permission";
    String write = "grant permission in "+projectName+" for "+userName+" to write";
    
    if(permissions == "Read")
      permissionScripts.add(read);
    if(permissions == "Write")
      permissionScripts.add(write);
    if(permissions == "Add Permission")
      permissionScripts.add(addPermission);
    if(permissions == "Read And Write")
    {
      permissionScripts.add(read);
      permissionScripts.add(write);
    }
    if(permissions == "Read And Add Permission")
    {
      permissionScripts.add(read);
      permissionScripts.add(addPermission);
    }
    if(permissions == "Write And Add Permission")
    {
      permissionScripts.add(write);
      permissionScripts.add(addPermission);
    }
    if(permissions == "Read, Write And Add Permission")
    {
      permissionScripts.add(read);
      permissionScripts.add(write);
      permissionScripts.add(addPermission);
    }
    return permissionScripts;
  }
  
  void createUserPermissions(List permissionScripts, String projectName)
  {
    for(int i = 0; i < permissionScripts.length; i++)
    {
      String scriptCommand = permissionScripts[i];
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(), 
                                                        (s) => moveToNextSuccess(permissionScripts, projectName), 
                                                        (s) => moveToNextFail(permissionScripts, projectName));
    }
  }
  
  void moveToNextSuccess(List permissionScripts, String projectName)
  {
    totalPassed++;
    if(totalFailed > 0)
    {
      ps.errorPrompt("Error-Adding-User-Project-Permissions");
      
    }
    else if(totalPassed == permissionScripts.length)
    {
      ps.projectSuccessPrompt("User-Added-To-Project", projectName, null);
    }
    return;
  }
  
  void moveToNextFail(List permissionScripts, String projectName)
  {
    totalFailed++;
    if(totalFailed > 0)
    {
      ps.errorPrompt("Error-Adding-User-Project-Permissions");
      
    }
    else if(totalPassed == permissionScripts.length)
    {
      ps.projectSuccessPrompt("User-Removed-From-Project", projectName, null);
    }
    return;
  }
  
  String createAddUserScriptCommand(String username, String projectName)
  {
    return "add user "+username+" to "+projectName;
  }
  
  String createRemoveUserScriptCommand(String username, String projectName)
  {
    return "remove user "+username+" from "+projectName;
  }
  
  void togglePermissionsBox(String addRemoveUserId, String dropdownId, String liId, String buttonId)
  {
    Element liElement = querySelector(liId);
    InputElement button = querySelector(buttonId);
    SelectElement addRemoveBox = querySelector(addRemoveUserId);
    SelectElement permissionsBox = querySelector(dropdownId);
    String addRemoveString = addRemoveBox.value;
    
    if(addRemoveString == "Remove User")
    {
      button.value = "Remove User";
      liElement.style.display = "none";
      permissionsBox.options[0].selected = true;
      permissionsBox.disabled = true;
    }
    else if(addRemoveString == "Add User")
    {
      button.value = "Add User";
      liElement.style.display = "block";
      permissionsBox.disabled = false;
    }
  }
}