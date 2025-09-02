serialPort(ttyEmulatedPort1).

/* Objetivo inicial */
!start.

+!start: 
    serialPort(Port) <- 
    .print("Conectando ao alimentador...");
    .argo.port(Port);
    .argo.percepts(open);
    .argo.limit(1000).

-!start <- .print("Erro na conexao! Verifique a porta serial.").

/* Selecionando Animal */

+alteracaoNoPote(1) <- 
    .print("O pote de racao foi alterado.");
    !enviarEstadoCompleto.

+animalSelecionado(1) <- 
    .print("Animal 1 selecionado.").

+animalSelecionado(2) <- 
    .print("Animal 2 selecionado.").

+poteRacao(cheio) <- 
    .print("Pote de racao cheio!").

+poteRacao(vazio) <-
    .print("Pote de racao vazio!").

+!obterEstadoCompleto[source(X)] <-  
    ?poteRacao(EstadoPote);  
    ?animalSelecionado(Animal);  
    ?racaoNivel(Nivel);  
    .concat("Estado do Pote: ", EstadoPote, " | Animal Selecionado: ", Animal, " | Peso Restante: ", Nivel, Resposta);
    .send(X, tell, estadoCompleto(Resposta));
    .send(X, untell, estadoCompleto(Resposta)).

+!enviarEstadoCompleto <-  
    ?poteRacao(EstadoPote);  
    ?animalSelecionado(Animal);  
    ?racaoNivel(Nivel);  
    .concat("Houve uma alteracao no peso da racao. O animal (", Animal, ") esta proximo ao recipiente. Estado: ", EstadoPote, ". Peso restante: ", Nivel, "g.", Resposta);
    .send(uhura, tell, estadoCompleto(Resposta));
    .send(uhura, untell, estadoCompleto(Resposta)).