library addProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddProject
{
  void addProject(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    InputElement projectNameBox = querySelector("#projName");
    InputElement projectLocationBox = querySelector("#projLocation");
    SelectElement pluginsSelectedBox = querySelector("#pluginsRight");
    String projectName = projectNameBox.value;
    String projectLocation = projectLocationBox.value;
    String scriptCommand;
    
    if(projectNameBox.value.trim() == "" || projectNameBox.value == null)
    {
      ps.errorPrompt("No-Project-Name");
      return;
    }
    
    if(projectLocationBox.value.trim() == "" || projectLocationBox.value == null)
    {
      ps.errorPrompt("No-Project-Location");
      return;
    }
    
    scriptCommand = createAddProjectScriptString(projectName, projectLocation);
    if(pluginsSelectedBox.length == 0)
    {
      ServerRequest.createProject(scriptCommand, ServerRequest.defaultUri(), 
          (s) => addProjectSuccess(s), (s) => addProjectFail(s));
    }
    else if(pluginsSelectedBox.length > 0)
    {
      ServerRequest.createProject(scriptCommand, ServerRequest.defaultUri(), 
          addHelpers(), (s) => addProjectFail(s));
    }
    
  }
  
  addHelpers()
  {
    SelectElement pluginsSelectedBox = querySelector("#pluginsRight");
    for(int i = 0; i < pluginsSelectedBox.length; i++)
    {
      window.alert(pluginsSelectedBox.value[i]);
      String plugin = pluginsSelectedBox.value[i];
      String helperScriptCommand = createHelpersScriptString(plugin);
      ServerRequest.addHelperToProject(helperScriptCommand, ServerRequest.defaultUri(), moveToNext(), addHelperFail());
    }

  }
  
  moveToNext()
  {
    
  }
  
  addHelperFail()
  {
    
  }
  
  String createHelpersScriptString(String plugin)
  {
    InputElement projectNameBox = querySelector("#projName");
    String projectName = projectNameBox.value;
    return "portfolio add helper "+plugin+" to "+projectName;
  }
  
  String createAddProjectScriptString(String projectName, String projectLocation)
  {
    return "portfolio add project "+projectName+" in "+projectLocation;
  }
  
  void addProjectSuccess(String response)
  {
    
  }
  
  void addProjectFail(String response)
  {
    
  }
}