library projectSecurity;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class ProjectSecurity
{
  PopupConstructor pc = new PopupConstructor();
  PopupSelection ps = new PopupSelection();
  
  void secureOrUnsecureProject(String secureSelectId, String projectSelectId, String loggedInAsId)
  {
    SelectElement secureOrUnsecure = querySelector(secureSelectId);
    SelectElement projectList = querySelector(projectSelectId);
    OutputElement loggedInUser = querySelector(loggedInAsId);
    
    String selectedProject = projectList.value;
    String selectedSecurity = secureOrUnsecure.value;
    String username = loggedInUser.innerHtml;
    window.alert("sp1");
    window.alert(selectedProject);
    window.alert(selectedSecurity);
    window.alert(username);
    
    if(selectedSecurity == "Secured Project")
    {
      window.alert("secure");
      List scriptCommands = createScriptCommandSecure(selectedProject, username);
      for(int i = 0; i < scriptCommands.length; i++)
      {
        String scriptCommand = scriptCommands[i];
        window.alert(scriptCommand);
        PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(),
                                                          (s) => projectSecurityPass(s, selectedProject),
                                                          (s) => projectSecurityFail(s));
      }
    }
    else if(selectedSecurity == "Unsecured Project")
    {
      window.alert("unsecure");
      String scriptCommand = createScriptCommandInsecure(selectedProject);
      window.alert(scriptCommand);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(), 
                                                        (s) => projectUnSecurePass(s, selectedProject),
                                                        (s) => projectSecurityFail(s));
    }
    
    
  }
  
  List createScriptCommandSecure(String projectName, String userName)
  {
    List<String> commands = new List<String>();
    String addUser = "add user "+userName+" to "+projectName+' "authentication.username=admin" "authentication.password=admin"';
    String grantPermission = "grant permission in "+projectName+" for "+userName+' to add-permission "authentication.username=admin" '+
        '"authentication.password=admin"';
    commands.add(addUser);
    commands.add(grantPermission);
    return commands;
  }
  
  String createScriptCommandInsecure(String projectName)
  {
    return "make project "+projectName+" insecure";
  }
  
  projectUnSecurePass(String response, String projectName)
  {
    pc.getResult(ps.projectSuccessPrompt("Unsecure-Project-Success", projectName, null), "");
  }
  
  projectSecurityPass(String response, String projectName)
  {
    window.alert("secured pass");
    pc.getResult(ps.projectSuccessPrompt("Secure-Project-Success", projectName, null), "");
  }
  
  projectSecurityFail(String response)
  {
    pc.getResult(ps.errorPrompt("Project-Security-Fail"), response);
  }
}