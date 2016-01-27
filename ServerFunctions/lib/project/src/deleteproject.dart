library deleteProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class DeleteProject
{
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  
  deleteProject(MouseEvent m)
  {
    SelectElement projectNameBox = querySelector("#projectNames");
    String projectName;
    window.alert(projectNameBox.length.toString());
    
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
    ServerRequest.deleteProject(deleteProjectScript, ServerRequest.defaultUri(), (s) => resetProjects(), (s) => deleteFail(s));
  }
  
  String createDeleteScript(String projectName)
  {
    String deleteScript = "delete project "+projectName;
    return deleteScript;
  }
  
  resetProjects()
  {
    ServerRequest.resetAllProjects(ServerRequest.defaultUri(), deleteSuccessful());
  }
  
  deleteSuccessful()
  {
    pc.getResult(ps.projectSuccessPrompt("Delete-Project-Success"), "");
  }
  
  deleteFail(String response)
  {
    pc.getResult(ps.errorPrompt("Project-Delete-Fail"), response);
  }
}
