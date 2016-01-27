import 'dart:html';
import 'dart:async';
import 'xmlconstruct.dart';

class SoapRequest extends XmlConstruct
{
  StringBuffer buffer = new StringBuffer();
  Storage local = window.sessionStorage;
  HttpRequest request = new HttpRequest();
  
  encodeBasicAuthCredentials(String username, String password)
  {
    String credentials = username+":"+password;
    var base64 = window.btoa(credentials);
    window.sessionStorage['credentials'] = base64.toString();
  }
  
  void getDatabaseListResponse(Function onReturn)
  {
    sendDatabaseRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(xmlResponseList());
        }
      }
    });
  }
  
  getDatabaseStringResponse(Function onReturn)
  {
    sendDatabaseRequest().listen((ProgressEvent p)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(xmlResponseString());
        }
      }  
    });
  }
  
  void getLicenceListResponse(Function onReturn)
  {
    sendLicenceServerRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(xmlResponseList());
        }
      }
    });
  }
  
  void getLicenceStringResponse(Function onReturn)
  {
    sendLicenceServerRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(xmlResponseString());
        }
      }
    });
  }
  
  void getPortfolioListResponse(Function onReturn)
  {
    sendPortfolioRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(xmlResponseList());
        }     
      }
    });
  }
  
  void getPortfolioListOfListResponse(Function onReturn)
  {
    sendPortfolioRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(xmlResponseListOfList());
        }     
      }
    });
  }
  
  getPortfolioStringResponse(Function onReturn)
  {
    sendPortfolioRequest().listen((ProgressEvent p)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(xmlResponseString());
        }
      }  
    });
  }
  
  Stream<ProgressEvent> sendLicenceServerRequest()
  {
    String uriv = uriLicenceServer();
    request = new HttpRequest();
    request.open('POST', uriv);
    request.setRequestHeader('Content-Type', 'text/xml');
    buffer = setLicenceServerXml();
    request.send(buffer.toString());
    return request.onReadyStateChange;
  }
  
  Stream<ProgressEvent> sendDatabaseRequest()
  {
    String uriv = uriDatabase();
    request.open("POST", uriv);
    requestHeader();
    buffer = setDatabaseXml();
    request.send(buffer.toString());
    return request.onReadyStateChange;  
  }
  
  Stream<ProgressEvent> sendPortfolioRequest()
  {
    String uriv = uriPortfolio();
    request.open("POST", uriv);
    requestHeader();
    buffer = setPortfolioXml();
    request.send(buffer.toString());
    return request.onReadyStateChange;   
  }
  
  requestHeader()
  {
    request.setRequestHeader("accept", "text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2");
    request.setRequestHeader('Content-Type', 'text/xml');
    request.setRequestHeader("Authorization", "Basic "+local['credentials']);
  }  
  
  List xmlResponseList()
  {
    Node envelope;
    Node body;
    Node content;
    List<String> list = new List<String>();
    
    envelope = request.responseXml.nodes[0];
    body = envelope.nodes[0];
    content = body.nodes[0];
    for(Node n in content.nodes)
    {
      list.add(n.text);
    }
    return list;  
  }
  
  List<List> xmlResponseListOfList()
  {
    Node envelope;
    Node body;
    Node content;
    
    List<List> listOfLists = new List<List>();
    
    envelope = request.responseXml.nodes[0];
    body = envelope.nodes[0];
    content = body.nodes[0];
    for(Node n in content.nodes)
    {
      List<String> list = new List<String>();
      for(int i = 0; i < n.childNodes.length; i++)
      {
        Node singleElement = n.childNodes.elementAt(i);
        String element = singleElement.text;
        list.add(element);
      }
      listOfLists.add(list);
    }
    return listOfLists;
  }
  
  String xmlResponseString()
  {
    Node envelope;
    Node body;
    Node response;
    
    envelope = request.responseXml.nodes[0];
    body = envelope.nodes[0];
    response = body.nodes[0];
    return response.text;
  }
}