library deleteProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class DeleteProject
{
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  
  deleteProject(String projectNamesBoxId)
  {
    SelectElement projectNameBox = querySelector(projectNamesBoxId);
    String projectName;
    
    if(projectNameBox.value == "" || projectNameBox.value == null)
    {
      ps.errorPrompt("No-Project-Name");
      return;
    }
    
    for(int i = 0; i < projectNameBox.length; i++)
    {
      if(projectNameBox.options[i].selected == true)
      {
        projectName = projectNameBox.options[i].innerHtml;
      }
    }
    
    
    String deleteProjectScript = createDeleteScript(projectName);
    PortfolioServerRequests.deleteProject(deleteProjectScript, PortfolioServerRequests.defaultUri(), 
                                          (s) => resetProjects(projectName), (s) => deleteFail(s));
  }
  
  String createDeleteScript(String projectName)
  {
    String deleteScript = "delete project "+projectName;
    return deleteScript;
  }
  
  resetProjects(String projectName)
  {
    PortfolioServerRequests.resetAllProjects(PortfolioServerRequests.defaultUri(), deleteSuccessful(projectName));
  }
  
  deleteSuccessful(String projectName)
  {
    PortfolioServerRequests.resetAllProjects(PortfolioServerRequests.defaultUri(), null);
    pc.getResult(ps.projectSuccessPrompt("Delete-Project-Success", projectName, null), "");
  }
  
  deleteFail(String response)
  {
    pc.getResult(ps.errorPrompt("Project-Delete-Fail"), response);
  }
}
