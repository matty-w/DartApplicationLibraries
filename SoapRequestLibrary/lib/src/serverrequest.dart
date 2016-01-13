library server;

import 'soaprequest.dart';
import 'dart:html';

class ServerRequest extends SoapRequest
{
  static void licenceAdminLogin(String username, String password, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("checkAdminLogin");
    result.addArgument(username);
    result.addArgument(password);
    result.getLicenceStringResponse((s) => (s=="true")? onPass() : onFail ());   
  }
  
  static void checkPermissions(String adminName,String adminPassword,String host,Function action)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("getPermissions");
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse(action);
  }
  
  static void addLicence(String user,String date,String filter,String adminName,String password,
                         String host,Function onPass,Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("addLicence");
    result.addArgument(user);
    result.addArgument(date);
    result.addArgument(filter);
    result.addArgument(adminName);
    result.addArgument(password);
    result.getLicenceStringResponse((String s) => (s.contains("-"))? onPass(s) : onFail (s));
  }
  
  static void addAdminUser(String user, String password, String adminName, String adminPassword, 
                           String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("add-user "+user+","+password);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void addPermission(String user, String permissionChoice, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("add-permission "+user+","+permissionChoice);
    result.addArgument(adminName);
    result.addArgument(adminPassword); 
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void removePermission(String user, String permissionChoice, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("remove-permission "+user+","+permissionChoice);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void regenerateLicence(String licenceId, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("regenerateProductKeyFor");
    result.addArgument(licenceId);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s.contains("-"))? onPass(s) : onFail(s));
  }
  
  static void removeUser(String user, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("delete-user "+user);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void removeLicence(String licenceKey, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("removeLicence");
    result.addArgument(licenceKey);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void searchForLicences(String searchCriteria, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("licencesFor");
    result.addArgument(searchCriteria);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceListResponse((List s) => (s.length > 0)? onPass(s) : onFail(s));
  }
  
  static void changeAdminPassword(String user, String newPassword, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("change-password "+user+","+newPassword);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void basicAuthLogin(String usernameBasic, String passwordBasic, String host, Function onPass, Function onFail)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.encodeBasicAuthCredentials(usernameBasic, passwordBasic);
      result.setAction("test");
      result.addArgument("version");
      result.setHost(host);
      result.getPortfolioStringResponse((String s) => (s.contains("build"))? onPass(s) : onFail (s));
    }
    
    static void listProjects(String host, Function onPass)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setAction("listProjects");
      result.setHost(host);
      result.getDatabaseListResponse((s) => onPass(s));
    }
    
    static void getRegistryFiles(String project, String host, Function onPass)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setHost(host);
      result.setAction("listRegistryEntriesFor");
      result.addArgument(project);
      result.getDatabaseListResponse((s) => onPass(s));
    }
    
    static void deleteRegistryFile(String file, String host, Function onPass, Function onFail)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setHost(host);
      result.setAction("removeRegistryEntry");
      result.addArgument(file);
      result.getDatabaseStringResponse((String s) => (s == ("done"))? onPass(s) : onFail (s));
    }
    
    static void addRegistryFile(String key, String path, String host, Function onPass, Function onFail)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setHost(host);
      result.setAction("addRegistryEntry");
      result.addArgument(key);
      result.addArgument(path);
      result.getDatabaseStringResponse((String s) => (s == ("SUCCESS"))? onPass(s) : onFail (s));
    }
    
    static void editRegistryFile(String key, String path, String host, Function onPass, Function onFail)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setHost(host);
      result.setAction("editRegistryFile");
      result.addArgument(key);
      result.addArgument(path);
      result.getDatabaseStringResponse((String s) => (s == ("SUCCESS"))? onPass(s) : onFail (s));
    }
    
    static void showProjectFolders(String projectName, String key, String host, Function onPass, Function onFail)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setHost(host);
      result.setAction("getPropertiesList");
      result.addArgument(projectName);
      result.addArgument(key);
      result.getPortfolioListResponse((List s) => (s.length > 0)? onPass(s) : onFail(s));
    }
    
    static void showProjectFiles(String projectPath, String key, String host, Function onPass)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setHost(host);
      result.setAction("getPropertiesList");
      result.addArgument(projectPath);
      result.addArgument(key);  
      result.getPortfolioListResponse((s) => onPass(s));
    }
    
    static void createProject(String scriptCommand, String host, Function onPass, Function onFail)
    {
      window.alert(scriptCommand);
    }
    
    static void addHelperToProject(String addHelperScript, String host, Function onPass, Function onFail)
    {
      
    }
    
    static void listPluginsAndDescriptions(String host, Function onPass)
    {
      ServerRequest result;
      result = new ServerRequest();
      result.setHost(host);
      result.setAction("getPropertiesList");
      result.addArgument("shared");
      result.addArgument("plugins"); 
      result.getPortfolioListResponse((s) => onPass(s));
    }
  
    static String defaultUri()
    {
      return window.location.host;
    }
    
    @override
    licenceNamespace()
    {
      return "licence.zizo.decsim.com";
    }
    
    String licencePath()
    {
      return "DataReLicenceServer/LicenceServer";
    }
    
    @override
    databaseNamespace()
    {
      return "service.zizodb.decsim.com";
    }
    
    @override
    portfolioNamespace()
    {
      return "server.decsim.com";
    }
    
    String databasePath()
    {
      return "DatabaseService/DatabaseService";
    }
    
    String portfolioPath()
    {
      return "PortfolioService/PortfolioServiceService";
    }
}