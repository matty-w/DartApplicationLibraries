
import 'popupbuilder.dart';

class PopupSelection
{
  PopupBuilder pb = new PopupBuilder();
  
  void registrySuccessPopup(String successAction)
  {
    pb.createRegistrySuccessPrompt(successAction);
  }
  
  void addRegistryPrompt()
  {
    pb.createAddRegistryPrompt();
  }
  void addRegistryConfirmPrompt(String regName, String contentPath)
  {
    pb.createAddRegistryConfirmPrompt(regName, contentPath);
  }
  
  void editRegistryConfirmPrompt(String regName, String contentPath)
  {
    pb.createEditRegistryConfirmPrompt(regName, contentPath);
  }
  
  void removeRegistryPrompt(List keys)
  {
    pb.createDeleteRegistryPrompt(keys);
  }
  
  void editRegistryPrompt(String key)
  {
    pb.createEditRegistryPrompt(key);
  }
  
  errorPrompt(String errorMessage)
  {
    pb.createErrorPrompt(errorMessage);
  }
  
  licenceSuccessPrompt(String successAction)
  {
    pb.createLicenceSuccessPrompt(successAction);
  }
  
  addProjectSuccessPrompt(String successAction, String projectName, List helpers)
  {
    pb.createAddProjectSuccessPrompt(successAction, projectName, helpers);
  }
  
  projectSuccessPrompt(String successAction, String projectName, String folderName)
  {
    pb.createProjectSuccessPrompt(successAction, projectName, folderName);
  }
  
  licenceClipboardPopup(String successAction)
  {
    pb.createLicenceClipboardPopup(successAction);
  }
  
  addHelperFail(String errorMessage, String projectName, List failedHelpers)
  {
    pb.createProjectFailPrompt(errorMessage, projectName, failedHelpers);
  }
  
  void licenceFormatPopup()
  {
    pb.createLicenceFormatPopup();
  }
  
  void fileExplorerPopup()
  {
    pb.createFilePopup();
  }
}