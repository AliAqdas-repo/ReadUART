#include<String.h>
#define BUFF_LEN 784

char data_arr[BUFF_LEN];
int i = 0;
bool reading,writing = false;
#define BP 2
#define RD 3
#define WR 4


void setup()
{
  pinMode(BP, OUTPUT);
  pinMode(RD, OUTPUT);
  pinMode(WR, OUTPUT);



  digitalWrite(BP,LOW);
  digitalWrite(RD,HIGH);
  digitalWrite(WR,LOW);


  
  Serial.begin(115200);
  while(!Serial);
  reading = true;
  writing = false;
  i = 0 ;
}

void loop()
{
if(i < BUFF_LEN & reading)
{
  for(int i = 0; i < BUFF_LEN; i++)
  {
    while(true)
    {
     if(Serial.available() > 0)
     {
    
        data_arr[i] = Serial.read();
        digitalWrite(BP,HIGH);    
        break;
     }
     else
     {
       digitalWrite(BP,LOW);
     }
    }
  }
  reading = false;
  writing = true;
  digitalWrite(RD,LOW);
  digitalWrite(WR,HIGH);
}


if(!reading && writing)
{
  while(Serial.read() != 128)
    {
      digitalWrite(BP,HIGH);
    }
    digitalWrite(BP,LOW);
    for(int k = 0; k < BUFF_LEN ; k++) Serial.write(data_arr[k]);
    writing = false;
    reading = true ;
    digitalWrite(RD,HIGH);
    digitalWrite(WR,LOW);
//i++;
//if(i == BUFF_LEN) 
//{
//  while(1)
//  {
//    ;
//  }
//}
}
//if (i < 5 & writing)
//{
//  Serial.print(data_arr[i]);
//  digitalWrite(BP,HIGH);
//    delay(1000);
//    digitalWrite(BP,LOW);
//  i++;
//  if(i == 784)
//  {
//   i = 0;
//   reading = true;
//   writing = false;
//  }
//}

}
