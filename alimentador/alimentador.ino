#include <Javino.h> // https://javino.chon.group
#include <Servo.h>  // https://docs.arduino.cc/libraries/servo/

#define BOTAO_ALIMENTAR 2  
#define BOTAO_COMER 3       
#define BOTAO_ANIMAL1 4     
#define BOTAO_ANIMAL2 5     
#define LED_RACAO1 6        
#define LED_RACAO2 7        
#define SERVO_PIN 9         

Javino javino;
Servo servo;

int ultimoPeso = 0;
int racao = 0;
int racaoMax = 350;
bool animal1 = true;
bool botaoComerPressionado = false;

int loopCount = 0;

void serialEvent() { javino.readSerial(); }

void setup() {
  pinMode(BOTAO_ALIMENTAR, INPUT);
  pinMode(BOTAO_COMER, INPUT);
  pinMode(BOTAO_ANIMAL1, INPUT);
  pinMode(BOTAO_ANIMAL2, INPUT);
  pinMode(LED_RACAO1, OUTPUT);
  pinMode(LED_RACAO2, OUTPUT);

  javino.perceive(getExogenousPerceptions);
  servo.attach(SERVO_PIN);

  javino.start(9600);
}

void loop() {

	javino.run();	
	if (digitalRead(BOTAO_ALIMENTAR) == HIGH) { 
     alimentar();
    }
  
    if (digitalRead(BOTAO_COMER) == HIGH && !botaoComerPressionado) { 
        botaoComerPressionado = true;
        animalComeu();  
    } else if (digitalRead(BOTAO_COMER) == LOW) {
        botaoComerPressionado = false;  
    }

    if (digitalRead(BOTAO_ANIMAL1) == HIGH) {
    selecionarAnimal1();
  }
  if (digitalRead(BOTAO_ANIMAL2) == HIGH) {
    selecionarAnimal2();
  } 

}

void getExogenousPerceptions() {
	atualizarServo();

    javino.addPercept("alteracaoNoPote(0)");

	if (ultimoPeso != racao) {
      javino.addPercept("alteracaoNoPote(1)");
    }
	
   if (animal1) {
        javino.addPercept("animalSelecionado(1)");
    } else {
        javino.addPercept("animalSelecionado(2)");
    }

    if (racao == 0) {
        javino.addPercept("poteRacao(vazio)");
    } else if (racao == racaoMax) {
        javino.addPercept("poteRacao(cheio)");
    } else {
        javino.addPercept("poteRacao(parcial)");
    }

	loopCount++;
	javino.addPercept("racaoNivel(" +String(racao)+")");
	javino.addPercept("loopCount(" +String(loopCount)+")");
    ultimoPeso = racao;
}

void alimentar() {
    racao = racaoMax;
}

void animalComeu() {
   racao -= 100;
   if (racao < 0) racao = 0;
}

void selecionarAnimal1() {
    animal1 = true;
    digitalWrite(LED_RACAO1, HIGH);
    digitalWrite(LED_RACAO2, LOW);
}

void selecionarAnimal2() {
    animal1 = false;
    digitalWrite(LED_RACAO1, LOW);
    digitalWrite(LED_RACAO2, HIGH);
}

void atualizarServo() {
    int angulo = map(racao, 0, racaoMax, 0, 180);
    servo.write(angulo);
}
