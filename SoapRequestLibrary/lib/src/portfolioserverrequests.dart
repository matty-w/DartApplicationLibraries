library portfolioServerRequests;

import 'soaprequest.dart';
import 'dart:html';

class PortfolioServerRequests extends SoapRequest
{
  static void basicAuthLogin(String usernameBasic, String passwordBasic, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.encodeBasicAuthCredentials(usernameBasic, passwordBasic);
    result.setAction("test");
    result.addArgument("version");
    result.setHost(host);
    result.getPortfolioStringResponse((String s) => (s.contains("build"))? onPass(s) : onFail (s));
  }
  
  static void showProjectFolders(String projectName, String key, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("getPropertiesList");
    result.addArgument(projectName);
    result.addArgument(key);
    result.getPortfolioListResponse((List s) => (s.length > 0)? onPass(s) : onFail(s));
  }
  
  static void showProjectFiles(String projectPath, String key, String host, Function onPass)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("getPropertiesList");
    result.addArgument(projectPath);
    result.addArgument(key);  
    result.getPortfolioListResponse((s) => onPass(s));
  }
  
  static void runPortfolioScriptCommand(String scriptCommand, String expectedResponse, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("runScriptCommand");
    result.addArgument(scriptCommand);
    if(expectedResponse == "String-Response")
      result.getPortfolioStringResponse((String s) => (s == ("done"))? onPass(s) : onFail (s));
    else if(expectedResponse == "List-Response")
      result.getPortfolioListResponse((List s) => (s.length > 0)? onPass(s) : onFail(s));
    else if(expectedResponse == "List-Of-List-Response")
      result.getPortfolioListOfListResponse((s) => onPass(s));
  }
  
  static void setProjectProperty(String project, String property, String propertyValue, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("setProperty");
    result.addArgument(project);
    result.addArgument(property);
    result.addArgument(propertyValue);
    result.getPortfolioStringResponse((String s) => (s == ("done"))? onPass(s) : onFail(s));
    
  }
  
  static void projectSecuritySettings(String scriptCommand, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("runScriptCommand");
    result.addArgument(scriptCommand);
  }
  
  static void createProject(String scriptCommand, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("runScriptCommand");
    result.addArgument(scriptCommand);
    result.getPortfolioStringResponse((String s) => (s == ("done"))? onPass(s) : onFail (s));
  }
  
  static void addHelperToProject(String addHelperScript, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("runScriptCommand");
    result.addArgument(addHelperScript);
    result.getPortfolioStringResponse((String s) => (s == ("done"))? onPass(s) : onFail (s));
  }
  
  static void listPluginsAndDescriptions(String host, Function onPass)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("getPropertiesList");
    result.addArgument("shared");
    result.addArgument("plugins"); 
    result.getPortfolioListResponse((s) => onPass(s));
  }
  
  static void deleteProject(String deleteProjectScript, String host, Function onPass, Function onFail)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("runScriptCommand");
    result.addArgument(deleteProjectScript);
    result.getPortfolioStringResponse((String s) => (s == ("done"))? onPass(s) : onFail (s));
    
  }
  
  static void resetAllProjects(String host, Function onPass)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setHost(host);
    result.setAction("resetAllProjects");
    result.getPortfolioStringResponse((s) => onPass(s));
  }
  
  static void getProjectConfigs(String host, Function onPass)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setAction("getProjects");
    result.setHost(host);
    result.getPortfolioListOfListResponse((s) => onPass(s));
  }
  
  static void listProjectsDatabase(String host, Function onPass)
  {
    PortfolioServerRequests result;
    result = new PortfolioServerRequests();
    result.setAction("listProjects");
    result.setHost(host);
    result.getDatabaseListResponse((s) => onPass(s));
  }
  
  static String defaultUri()
  {
    return window.location.host;
  }
  
  @override
  portfolioNamespace()
  {
    return "server.decsim.com";
  }
  
  String portfolioPath()
  {
    return "PortfolioService/PortfolioServiceService";
  }
}