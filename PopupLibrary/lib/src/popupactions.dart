

import 'dart:html';

class PopupActions
{
  String licenceName;
  
  void hideCommandButtons(bool noButton, bool yesButton, bool okButton, bool dismissFinal, bool pageActionButton)
  {
    ButtonElement button1 = querySelector("#no");
    ButtonElement button2 = querySelector("#yes");
    ButtonElement button3 = querySelector("#ok");
    ButtonElement button4 = querySelector("#dismissFinal");
    ButtonElement button5 = querySelector("#popupAction");


    button1.hidden = noButton;
    button2.hidden = yesButton;
    button3.hidden = okButton;
    button4.hidden = dismissFinal; 
    button5.hidden = pageActionButton; 
  }
  
  void dismissBasicPromptForExplorer()
  {
    querySelector("#addBreak").hidden = true;
    querySelector("#addLabel1").style.display = "none";
    querySelector("#addLabel2").style.display = "none";
    querySelector("#browseText").style.display = "none";
    querySelector("#browseButton").style.display = "none";
    querySelector("#keyText").style.display = "none";
    querySelector("#ulRegKey").style.display = "none";
    querySelector("#ulConPath").style.display = "none";
    dismiss("#popUpDiv");
  }
  
  void dismissBasicPrompt(MouseEvent e)
  {
    querySelector("#addBreak").hidden = true;
    querySelector("#addLabel1").style.display = "none";
    querySelector("#addLabel2").style.display = "none";
    querySelector("#browseText").style.display = "none";
    querySelector("#browseButton").style.display = "none";
    querySelector("#keyText").style.display = "none";
    querySelector("#ulRegKey").style.display = "none";
    querySelector("#ulConPath").style.display = "none";   
    dismiss("#popUpDiv");
  }
  
  void dismiss(String popupId)
  {
    hide("#blanket");
    hide(popupId);
  }
  
  void hide(div_id)
  {
    DivElement el = querySelector(div_id);  
    el.style.display = "none";   
  }
  
  void dismissFileExplorer(MouseEvent m)
  {
    dismiss("#fileBrowserDiv");
  }
  
  void dismissBasicPromptReload(MouseEvent m)
  {
    window.localStorage['finishedFilePath'] = "";
    querySelector("#addBreak").hidden = true;
    querySelector("#addLabel1").style.display = "none";
    querySelector("#addLabel2").style.display = "none";
    querySelector("#browseText").style.display = "none";
    querySelector("#browseButton").style.display = "none";
    querySelector("#keyText").style.display = "none";
    querySelector("#ulRegKey").style.display = "none";
    querySelector("#ulConPath").style.display = "none";
    dismiss("#popUpDiv");
    window.location.reload();
  }
  
  void show(div_id)
  {
    DivElement el = querySelector(div_id);  
    el.style.display = "block";  
  }
  
  String getLicenceName()
  {
    return licenceName;
  }
  
  void getResult(Function popup, String response)
  {
    OutputElement output = querySelector("#serverResponse");
    output.innerHtml = response;
    window.sessionStorage["licenceName"] = response;
    popup; 
  }
}