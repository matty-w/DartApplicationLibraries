
class XmlConstruct
{
  String action;
  List<Object> arguments = new List();
  StringBuffer buffer = new StringBuffer();
  String _host;
  
  addArgument(String addArgument)
  {
    arguments.add(addArgument);
  }

  String databaseNamespace()
  {
    return "";
  }
  
  String databasePackageName()
  {
    return host()+"/"+databasePath();
  }
  
  String licencePackageName()
  {
    return host()+"/"+licencePath();
  }
  
  String licencePath()
  {
    return "";
  }
  
  String databasePath()
  {
    return "";
  }
  
  String getAction()
  {
    return action;
  }
  
  String getArgument(int i)
  {
    return arguments[i];
  }
  
  String host()
  {
    return _host;
  }
  
  String licenceNamespace()
  {
    return "";
  }
  
  int numberOfArguments()
  {
    return arguments.length;
  }
  
  String portfolioNamespace()
  {
    return "";
  }
  
  String portfolioPackageName()
  {
    return host()+"/"+portfolioPath();
  }
  
  String portfolioPath()
  {
    return "";
  }
  
  setAction(String setAction)
  {
    action = setAction;
  }

  StringBuffer setDatabaseXml()
  {
    writeXmlHeader();
    writeDatabaseXmlBody();
    writeXmlFooter();
    return buffer;
  }
  
  setHost(String setHost)
  {
    _host = setHost;
  }
  
  StringBuffer setLicenceServerXml()
  {
    writeXmlHeader();
    writeLicenceServerXmlBody();
    writeXmlFooter();
    return buffer;
  }
  
  StringBuffer setPortfolioXml()
  {
    writeXmlHeader();
    writePortfolioXmlBody();
    writeXmlFooter();
    return buffer;
  }
  
  String uriDatabase()
  {
    return "http://"+databasePackageName();
  }
  
  String uriLicenceServer()
  {
    return "http://"+licencePackageName();
  }
  
  String uriPortfolio()
  {
    return "http://"+portfolioPackageName();
  }
  
  void writeDatabaseXmlBody()
  {
    buffer.writeln("<ns2:"+getAction()+" xmlns:ns2='http://"+databaseNamespace()+"/'>");
    writeRequestArguments();
    buffer.writeln("</ns2:"+getAction()+">");
  }
  
  writeLicenceServerXmlBody()
  {
    buffer.writeln("<ns2:"+getAction()+" xmlns:ns2='http://"+licenceNamespace()+"/'>");
    writeRequestArguments();
    buffer.writeln("</ns2:"+getAction()+">");
  }
  
  void writePortfolioXmlBody()
  {
    buffer.writeln("<ns2:"+getAction()+" xmlns:ns2='http://"+portfolioNamespace()+"/'>");
    writeRequestArguments();
    buffer.writeln("</ns2:"+getAction()+">");
  }
  
  void writeRequestArgument(int i)
  {
    buffer.writeln("<arg"+i.toString()+">"+getArgument(i)+"</arg"+i.toString()+">");
  }
  
  void writeRequestArguments()
  {
    for(int i = 0; i < numberOfArguments(); i++)
    {
      writeRequestArgument(i);
    }
  }
  
  void writeXmlFooter()
  {
    buffer.writeln("</S:Body>");
    buffer.writeln("</S:Envelope>");
  }
  
  void writeXmlHeader()
  {
    buffer.writeln("<?xml version='1.0' encoding='UTF-8'?>");
    buffer.writeln("<S:Envelope xmlns:S='http://schemas.xmlsoap.org/soap/envelope/'>");
    buffer.writeln("<S:Header/>");
    buffer.writeln("<S:Body>");
  }
}