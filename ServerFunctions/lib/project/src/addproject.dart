library addProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddProject
{
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  List failedHelpers = new List();
  int totalPassed = 0;
  
  void addProject(String projectNameBoxId, String projectLocationBoxId, String pluginsRightBoxId)
  {
    window.alert("ap1");
    InputElement projectNameBox = querySelector(projectNameBoxId);
    window.alert("ap2");
    SelectElement projectLocationBox = querySelector(projectLocationBoxId);
    window.alert("ap3");
    SelectElement pluginsSelectedBox = querySelector(pluginsRightBoxId);
    window.alert("ap4");
    String projectName = projectNameBox.value;
    window.alert("ap5");
    String projectLocation = projectLocationBox.value;
    window.alert("ap6");
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
      PortfolioServerRequests.createProject(scriptCommand, PortfolioServerRequests.defaultUri(), 
          (s) => addProjectSuccess(s, projectName), (s) => addProjectFail(s));
    }
    if(pluginsSelectedBox.length > 0)
    {
      window.alert("plugins selected");
      PortfolioServerRequests.createProject(scriptCommand, PortfolioServerRequests.defaultUri(), 
                                           (s) => addHelpers(), (s) => addProjectFail(s));
    }
    
  }
  
  addHelpers()
  {
    window.alert("inside helpers1");
    SelectElement pluginsSelectedBox = querySelector("#pluginsRight");
    window.alert("inside helpers2");
    InputElement projectNameBox = querySelector("#projName");
    window.alert("inside helpers3");
    String projectName = projectNameBox.value;
    window.alert("inside helpers4");
    List pluginList = new List();
    window.alert("inside helpers5");
    for(int i = 0; i < pluginsSelectedBox.length; i++)
    {
      OptionElement pluginOption = new OptionElement();
      pluginOption = pluginsSelectedBox.options[i];
      String plugin = pluginOption.innerHtml;
      pluginList.add(plugin);
      String helperScriptCommand = createHelpersScriptString(plugin);
      PortfolioServerRequests.addHelperToProject(helperScriptCommand, PortfolioServerRequests.defaultUri(), 
          moveToNextSuccess(projectName, pluginList), moveToNextFail(plugin));
    }
  }
  
  moveToNextSuccess(String projectName, List pluginList)
  {
    totalPassed++;
    window.alert(failedHelpers.length.toString());
    window.alert("passed plugins = "+totalPassed.toString());
    if(failedHelpers.length > 0)
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
    else if(totalPassed == pluginList.length)
    {
      window.alert("total passed: "+totalPassed.toString()+" | "+"plugins list: "+pluginList.length.toString());
      pc.getResult(ps.addProjectSuccessPrompt("Add-Project-With-Helpers", projectName, pluginList), "");
    }
  }
  
  moveToNextFail(String plugin)
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
    PortfolioServerRequests.resetAllProjects(PortfolioServerRequests.defaultUri(), null);
    pc.getResult(ps.addProjectSuccessPrompt("Add-Project-Without-Helpers", projectName, null), "");
  }
  
  void addProjectFail(String response)
  {
    pc.getResult(ps.errorPrompt("Add-Project-Fail"), response);
  }
}