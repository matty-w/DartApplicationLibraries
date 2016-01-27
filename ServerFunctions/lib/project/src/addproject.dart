library addProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddProject
{
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  List failedHelpers = new List();
  
  void addProject(MouseEvent m)
  {
    InputElement projectNameBox = querySelector("#projName");
    SelectElement projectLocationBox = querySelector("#projLocation");
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
      window.alert(scriptCommand);
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
          moveToNext(), helperFailCounter(plugin));
    }
    window.alert(failedHelpers.length.toString());
    
    if(failedHelpers.length == 0)
    {
      window.alert("inside failedHelpers = 0 ");
      pc.getResult(ps.addProjectSuccessPrompt("Add-Project-With-Helpers", projectName, pluginList), "");
    }
    else if(failedHelpers.length > 0)
    {
      List helpers = new List();
      helpers = failedHelpers;
      for(int i = 0; i < failedHelpers.length; i++)
      {
        failedHelpers.removeLast();
      }
      window.alert(failedHelpers.length.toString());
      pc.getResult(ps.addHelperFail("Add-Helper-Fail", projectName, helpers), "");
    }


  }
  
  moveToNext()
  {
    return;
  }
  
  helperFailCounter(String plugin)
  {
    failedHelpers.add(plugin);
  }
  
  String createHelpersScriptString(String plugin)
  {
    InputElement projectNameBox = querySelector("#projName");
    String projectName = projectNameBox.value;
    return "add helper "+plugin+" to "+projectName;
  }
  
  String createAddProjectScriptString(String projectName, String projectLocation)
  {
    InputElement locationBox = querySelector("#projLocation");
    String scriptString;
    if(locationBox.value == "Default")
    {
      scriptString = "add project "+projectName;
    }
    return scriptString;
  }
  
  void addProjectSuccess(String response, String projectName)
  {
    pc.getResult(ps.addProjectSuccessPrompt("Add-Project-Without-Helpers", projectName, null), "");
  }
  
  void addProjectFail(String response)
  {
    pc.getResult(ps.errorPrompt("Add-Project-Fail"), response);
  }
}