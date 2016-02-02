
import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddUserToProject
{
  void addUserToProject(String projectBoxId, String usernameBoxId)
  {
    SelectElement projectNamebox = querySelector(projectBoxId);
    InputElement userNameBox = querySelector(usernameBoxId);
    
    String user = userNameBox.value;
    String projectName = projectNamebox.value;
    String scriptCommand = createAddUserScriptCommand(user, projectName);
    
    //ServerRequest.runPortfolioScriptCommand(scriptCommand, "String-Response", ServerRequest.defaultUri(), onPass, onFail);
  }
  
  String createAddUserScriptCommand(String username, String projectName)
  {
    return "add user "+username+" to "+projectName;
  }
}