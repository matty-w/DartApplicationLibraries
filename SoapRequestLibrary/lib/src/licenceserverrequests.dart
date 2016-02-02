library licenceServerRequests;


import 'soaprequest.dart';
import 'dart:html';

class LicenceServerRequests extends SoapRequest
{
  static void licenceAdminLogin(String username, String password, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("checkAdminLogin");
    result.addArgument(username);
    result.addArgument(password);
    result.getLicenceStringResponse((s) => (s=="true")? onPass() : onFail ());   
  }
  
  static void checkLicencePermissions(String adminName,String adminPassword,String host,Function action)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("getPermissions");
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse(action);
  }
  
  static void addLicence(String user,String date,String filter,String adminName,String password,
                         String host,Function onPass,Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("addLicence");
    result.addArgument(user);
    result.addArgument(date);
    result.addArgument(filter);
    result.addArgument(adminName);
    result.addArgument(password);
    result.getLicenceStringResponse((String s) => (s.contains("-"))? onPass(s) : onFail (s));
  }
  
  static void addAdminLicenceUser(String user, String password, String adminName, String adminPassword, 
                           String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("add-user "+user+","+password);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void addLicencePermission(String user, String permissionChoice, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("add-permission "+user+","+permissionChoice);
    result.addArgument(adminName);
    result.addArgument(adminPassword); 
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void removeLicencePermission(String user, String permissionChoice, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("remove-permission "+user+","+permissionChoice);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void regenerateLicence(String licenceId, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("regenerateProductKeyFor");
    result.addArgument(licenceId);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s.contains("-"))? onPass(s) : onFail(s));
  }
  
  static void removeLicenceUser(String user, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("delete-user "+user);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void removeLicence(String licenceKey, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("removeLicence");
    result.addArgument(licenceKey);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
  }
  
  static void searchForLicences(String searchCriteria, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("licencesFor");
    result.addArgument(searchCriteria);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceListResponse((List s) => (s.length > 0)? onPass(s) : onFail(s));
  }
  
  static void changeAdminPassword(String user, String newPassword, String adminName, String adminPassword, String host, Function onPass, Function onFail)
  {
    LicenceServerRequests result;
    result = new LicenceServerRequests();
    result.setHost(host);
    result.setAction("perform");
    result.addArgument("change-password "+user+","+newPassword);
    result.addArgument(adminName);
    result.addArgument(adminPassword);
    result.getLicenceStringResponse((String s) => (s == "done")? onPass(s) : onFail(s));
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
}