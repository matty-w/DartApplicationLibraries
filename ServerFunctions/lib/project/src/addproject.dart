library addProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddProject
{
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  
  void addProject(MouseEvent m)
  {
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
          (s) => addProjectSuccess(s, projectName), (s) => addProjectFail(s));
    }
    if(pluginsSelectedBox.length > 0)
    {
      ServerRequest.createProject(scriptCommand, ServerRequest.defaultUri(), (s) => addHelpers(), (s) => addProjectFail(s));
    }
    
  }
  
  addHelpers()
  {
    SelectElement pluginsSelectedBox = querySelector("#pluginsRight");
    InputElement projectNameBox = querySelector("#projName");
    String projectName = projectNameBox.value;
    List pluginList = new List();
    for(int i = 0; i < pluginsSelectedBox.length; i++)
    {
      OptionElement pluginOption = new OptionElement();
      pluginOption = pluginsSelectedBox.options[i];
      String plugin = pluginOption.innerHtml;
      pluginList.add(plugin);
      String helperScriptCommand = createHelpersScriptString(plugin);
      ServerRequest.addHelperToProject(helperScriptCommand, ServerRequest.defaultUri(), 
          moveToNext(), (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
    }
    pc.getResult(ps.projectSuccessPrompt("Add-Project-With-Helpers", projectName, pluginList), "");

  }
  
  moveToNext()
  {
    return;
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
  
  void addProjectSuccess(String response, String projectName)
  {
    pc.getResult(ps.projectSuccessPrompt("Add-Project-Without-Helpers", projectName, null), "");
  }
  
  void addProjectFail(String response)
  {
    
  }
}