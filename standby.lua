-- Put Linn DSM into Standby
vDeviceID = fibaro:getSelfId();
selfIp = fibaro:get(vDeviceID, "IPAddress");
selfPort = fibaro:get(vDeviceID, "TCPPort");
enter = "\r\n";

fibaro:debug('Contacting with Linn DSM ...')
tcpSocket = Net.FTcpSocket(selfIp, selfPort);
firstResponse = tcpSocket:read();
fibaro:debug(firstResponse);
secondResponse = tcpSocket:read();
fibaro:debug(secondResponse);
fibaro:sleep(1000);

bytes, errorCode = tcpSocket:write("Action Ds/Product 2 SetStandby \"1\"".. enter);
if errorCode == 0 then 
  fibaro:debug("Done, bytes written: "..bytes);
else 
  fibaro:debug("Error:"..errorCode);
end
response = tcpSocket:read();
fibaro:debug(response);

bytes, errorCode = tcpSocket:write("Action Ds/Product 2 Standby".. enter);
if errorCode == 0 then 
  fibaro:debug("Done, bytes written: "..bytes);
else 
  fibaro:debug("Error:"..errorCode);
end
response = tcpSocket:read();
fibaro:debug(response);

fibaro:call(vDeviceID, "setProperty", "ui.Label1.value", response);

tcpSocket:disconnect()