library editProjectDetails;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class EditProjectDetails
{
  int correctRunThroughs = 0;
  
  void editProjectDetails(String projectNameId, String projectTitleBoxId, String projectDescriptionBoxId, String projectPluginsBoxId)
  {
    PopupConstructor pc = new PopupConstructor();
    PopupSelection ps = new PopupSelection();
    SelectElement selectedProjectBox = querySelector(projectNameId);
    InputElement projectTitleBox = querySelector(projectTitleBoxId);
    InputElement projectDescriptionBox = querySelector(projectDescriptionBoxId);
    SelectElement projectPluginsBox = querySelector(projectDescriptionBoxId);
    
    String selectedProject = selectedProjectBox.value;
    String projectTitle = projectTitleBox.value;
    String projectDescription = projectDescriptionBox.value;
    List selectedPlugins = projectPluginsBox.children;
    window.alert(selectedPlugins.length.toString());
    
    List<String> scriptCommands = createScriptCommands(selectedProject, projectTitle, projectDescription);
    
    for(int i = 0; i < scriptCommands.length; i++)
    {
      window.alert(scriptCommands[i]);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommands[i], "String-Response", PortfolioServerRequests.defaultUri(),
          moveToNext(), (s) => errorPrompt(s));
    }
    window.alert("correct run throughs: "+correctRunThroughs.toString());
    window.alert(scriptCommands.length.toString());
    if(correctRunThroughs == scriptCommands.length)
    {
      ps.projectSuccessPrompt("Project-Details-Edited", selectedProject);
    }
    
  }
  
  moveToNext()
  {
    correctRunThroughs++;
    return;
  }
  
  errorPrompt(String response)
  {
    window.alert("in error");
    PopupConstructor pc = new PopupConstructor();
    PopupSelection ps = new PopupSelection();
    pc.getResult(ps.errorPrompt("Error-Editing-Project"), response);
  }
  
  List<String> createScriptCommands(String project, String projectTitle, String projectDescription)
  {
    List<String> commands = new List<String>();
    
    if(projectTitle != null || projectTitle != "")
    {
      String command = "set title for project "+project+" to "+'"'+projectTitle+'"';
      commands.add(command);
    }
    if(projectDescription != null || projectDescription != "")
    {
      String command = "document project "+project+" with "+'"'+projectDescription+'"';
      commands.add(command);
    }
    
    return commands;
  }
}