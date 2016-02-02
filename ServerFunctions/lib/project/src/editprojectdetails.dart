library editProjectDetails;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class EditProjectDetails
{
  void editProjectDetails(String projectNameId, String projectTitleBoxId, String projectDescriptionBoxId, String projectPluginsBoxId)
  {
    SelectElement selectedProjectBox = querySelector(projectNameId);
    InputElement projectTitleBox = querySelector(projectTitleBoxId);
    InputElement projectDescriptionBox = querySelector(projectDescriptionBoxId);
    SelectElement projectPluginsBox = querySelector(projectDescriptionBoxId);
    
    String selectedProject = selectedProjectBox.value;
    window.alert(selectedProject);
    String projectTitle = projectTitleBox.value;
    window.alert(projectTitle);
    String projectDescription = projectDescriptionBox.value;
    window.alert(projectDescription);
    List selectedPlugins = projectPluginsBox.children;
    window.alert(selectedPlugins.length.toString());
    
    List<String> scriptCommands = createScriptCommands(selectedProject, projectTitle, projectDescription);
    
    for(int i = 0; i < scriptCommands.length; i++)
    {
      window.alert(scriptCommands[i]);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommands[i], "String-Response", PortfolioServerRequests.defaultUri(),
          moveToNext(), moveToNext());
    }
  }
  
  Function moveToNext()
  {
    
  }
  
  List<String> createScriptCommands(String project, String projectTitle, String projectDescription)
  {
    List<String> commands = new List<String>();
    
    if(projectTitle != null || projectTitle != "")
    {
      String command = "set title for project "+project+" to "+projectTitle;
      commands.add(command);
    }
    if(projectDescription != null || projectDescription != "")
    {
      String command = "document project "+project+" with "+projectDescription;
      commands.add(command);
    }
    
    return commands;
  }
}