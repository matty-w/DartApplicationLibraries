
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
  
  licenceClipboardPopup(String successAction)
  {
    pb.createLicenceClipboardPopup(successAction);
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