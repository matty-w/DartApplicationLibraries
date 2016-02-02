library projectSecurity;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class ProjectSecurity
{
  void secureOrUnsecureProject(String secureSelectId, String projectSelectId)
  {
    SelectElement secureOrUnsecure = querySelector(secureSelectId);
    SelectElement projectList = querySelector(projectSelectId);
    
    String selectedProject = projectList.value;
    String selectedSecurity = secureOrUnsecure.value;
    
    if(selectedSecurity == "Secured Project")
    {
      String scriptCommand = createScriptCommandSecure(selectedProject);
      PortfolioServerRequests.projectSecuritySettings(scriptCommand, PortfolioServerRequests.defaultUri(), (s) => projectSecurityPass(s), 
          (s) => projectSecurityFail(s));
    }
    else if(selectedSecurity == "Unsecured Project")
    {
      String scriptCommand = createScriptCommandInsecure(selectedProject);
      PortfolioServerRequests.projectSecuritySettings(scriptCommand, PortfolioServerRequests.defaultUri(), (s) => projectSecurityPass(s), 
          (s) => projectSecurityFail(s));
    }
    
    
  }
  
  String createScriptCommandSecure(String projectName)
  {
    return "make project "+projectName+" insecure";
  }
  
  String createScriptCommandInsecure(String projectName)
  {
    return "make project "+projectName+" insecure";
  }
  
  projectSecurityPass(String response)
  {
    
  }
  
  projectSecurityFail(String response)
  {
    
  }
}