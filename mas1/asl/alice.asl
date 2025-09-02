// Agent alice in project testingMailerArch
/* Initial beliefs and rules */

/*  To use GMX.com MAIL, please create TWO e-mail accounts in (https://www.gmx.com/mail/) */ 
aliceEmailAndPass("chonide.alimentador@gmx.com","chonidealimentador123").
emailProviderSettings(["imap.gmx.com",imaps],["mail.gmx.com",smtpOverTLS]).


/* Initial goals */
!start.

/* Plans */
+!start: aliceEmailAndPass(AliceEMail,AlicePass) & emailProviderSettings(Receiving,Sending) <- 
    .print("Configuring my Email!");
    .mailer.credentials(AliceEMail,AlicePass);
    .mailer.eMailService(Receiving,Sending);
.

-!start <- .print("Something is wrong! Consult tutorial at: https://github.com/chon-group/Mailer/wiki").

+estadoCompleto(Resposta) <-
	.mailer.sendEMail("yourmail@mail.com","Relatorio alimentador automatico",Resposta).
