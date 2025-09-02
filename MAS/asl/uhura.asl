kirkUUID("80d9c5b3-5327-4836-b722-7481061aff37").
myUUID("af467a22-eafc-4e87-9f57-882740ab0737").
gateway("skynet.chon.group", 5500).

!connect.

/* Plans */

+!connect: gateway(Server,Port) & myUUID(MyID)  <- 
    .print("Trying to connect to ",Server,":",Port);
    .connectCN(Server,Port,MyID).

+communication(trying)[source(X)] <-
    .print("Entreprise listen ",X);
    +conectado;
    .sendOut(X,tell,communication(ok));
    .wait(1000).

+estadoCompleto(Resposta) <-
    .print("Enviando resposta");
    ?conectado;
    ?kirkUUID(X);
    .sendOut(X, tell, estadoCompleto(Resposta));
    .sendOut(X, untell, estadoCompleto(Resposta)).