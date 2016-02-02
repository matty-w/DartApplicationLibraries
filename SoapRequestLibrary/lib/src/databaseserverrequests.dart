library databaseServerRequests;

import 'soaprequest.dart';
import 'dart:html';

class DatabaseServerRequests extends SoapRequest
{
  static void getRegistryFiles(String project, String host, Function onPass)
  {
    DatabaseServerRequests result;
    result = new DatabaseServerRequests();
    result.setHost(host);
    result.setAction("listRegistryEntriesFor");
    result.addArgument(project);
    result.getDatabaseListResponse((s) => onPass(s));
  }
  
  static void deleteRegistryFile(String file, String host, Function onPass, Function onFail)
  {
    DatabaseServerRequests result;
    result = new DatabaseServerRequests();
    result.setHost(host);
    result.setAction("removeRegistryEntry");
    result.addArgument(file);
    result.getDatabaseStringResponse((String s) => (s == ("done"))? onPass(s) : onFail (s));
  }
  
  static void addRegistryFile(String key, String path, String host, Function onPass, Function onFail)
  {
    DatabaseServerRequests result;
    result = new DatabaseServerRequests();
    result.setHost(host);
    result.setAction("addRegistryEntry");
    result.addArgument(key);
    result.addArgument(path);
    result.getDatabaseStringResponse((String s) => (s == ("SUCCESS"))? onPass(s) : onFail (s));
  }
  
  static void editRegistryFile(String key, String path, String host, Function onPass, Function onFail)
  {
    DatabaseServerRequests result;
    result = new DatabaseServerRequests();
    result.setHost(host);
    result.setAction("editRegistryFile");
    result.addArgument(key);
    result.addArgument(path);
    result.getDatabaseStringResponse((String s) => (s == ("SUCCESS"))? onPass(s) : onFail (s));
  }
  
  static void listProjectsDatabase(String host, Function onPass)
  {
    DatabaseServerRequests result;
    result = new DatabaseServerRequests();
    result.setAction("listProjects");
    result.setHost(host);
    result.getDatabaseListResponse((s) => onPass(s));
  }
  
  String databasePath()
  {
    return "DatabaseService/DatabaseService";
  }
  
  @override
  databaseNamespace()
  {
    return "service.zizodb.decsim.com";
  }
  
  static String defaultUri()
  {
    return window.location.host;
  }
}