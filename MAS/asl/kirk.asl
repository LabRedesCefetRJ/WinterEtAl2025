enterpriseUUID("af467a22-eafc-4e87-9f57-882740ab0737").
myUUID("80d9c5b3-5327-4836-b722-7481061aff37").
gateway("skynet.chon.group",5500).

!connect.

+!connect: gateway(Server,Port) & myUUID(ID) <- 
	.connectCN(Server,Port,ID);
	!testComm.

+!testComm: enterpriseUUID(Uhura) & not communication(ok)<-
	.print("Kirk to Enterprise...");
	.sendOut(Uhura, tell, communication(trying)); 
	.wait(5000);
	!testComm.

-!testComm.

+communication(ok)[source(X)]<-
	.print("IoT Gateway is working!").

+estadoCompleto(Resposta) <-
	.print("Estado atual: ", Resposta);
	.send(alice, tell, estadoCompleto(Resposta));
	.send(alice, untell, estadoCompleto(Resposta)).
	
	