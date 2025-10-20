/*
 * NRF24L01 Wireless Chat - Terminal A
 * 
 * Type messages in the Serial Monitor and they'll be sent wirelessly
 * to Terminal B. Messages from Terminal B will also be displayed here.
 * 
 * Hardware:
 * - Arduino Uno
 * - NRF24L01 module
 * - CE to pin 7, CSN to pin 8
 */

#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

RF24 radio(7, 8); // CE, CSN

// Addresses for bidirectional communication
const byte address_tx[6] = "00001";  // Address for sending (A to B)
const byte address_rx[6] = "00002";  // Address for receiving (B to A)

String inputMessage = "";
bool messageReady = false;

void setup() {
  Serial.begin(9600);
  
  Serial.println("NRF24L01 Wireless Chat - Terminal A");
  Serial.println("====================================");
  Serial.println("Type your message and press Enter to send");
  Serial.println("Messages from Terminal B will appear below");
  Serial.println("------------------------------------");
  Serial.println();
  
  // Initialize radio
  if (!radio.begin()) {
    Serial.println("ERROR: Radio initialization failed!");
    while (1) { delay(1000); }
  }
  
  // Configure radio
  radio.setPALevel(RF24_PA_LOW);
  radio.setDataRate(RF24_1MBPS);
  radio.setChannel(76);
  
  // Set up pipes for bidirectional communication
  radio.openWritingPipe(address_tx);      // Write to Terminal B
  radio.openReadingPipe(1, address_rx);   // Read from Terminal B
  
  radio.startListening(); // Start in receive mode
  
  Serial.print("Terminal A> ");
}

void loop() {
  // Check for incoming messages from Terminal B
  checkForIncomingMessages();
  
  // Check for user input from Serial Monitor
  checkForUserInput();
  
  // Send message if ready
  if (messageReady) {
    sendMessage();
    messageReady = false;
  }
  
  delay(10);
}

void checkForIncomingMessages() {
  if (radio.available()) {
    char receivedMessage[64] = "";
    radio.read(&receivedMessage, sizeof(receivedMessage));
    
    // Clear current input line and show received message
    Serial.println();
    Serial.print("Terminal B> ");
    Serial.println(receivedMessage);
    Serial.print("Terminal A> ");
    Serial.print(inputMessage); // Redisplay current input
  }
}

void checkForUserInput() {
  while (Serial.available()) {
    char c = Serial.read();
    
    if (c == '\n' || c == '\r') {
      if (inputMessage.length() > 0) {
        messageReady = true;
      }
    } else if (c == '\b' || c == 127) { // Backspace
      if (inputMessage.length() > 0) {
        inputMessage.remove(inputMessage.length() - 1);
        Serial.print("\b \b"); // Erase character visually
      }
    } else if (c >= 32 && c <= 126) { // Printable characters
      inputMessage += c;
      Serial.print(c); // Echo character
    }
  }
}

void sendMessage() {
  // Stop listening to send message
  radio.stopListening();
  
  // Convert string to char array for transmission
  char messageBuffer[64];
  inputMessage.toCharArray(messageBuffer, sizeof(messageBuffer));
  
  // Send the message
  bool result = radio.write(&messageBuffer, sizeof(messageBuffer));
  
  if (result) {
    Serial.println(" [SENT]");
  } else {
    Serial.println(" [FAILED]");
  }
  
  // Clear input and start listening again
  inputMessage = "";
  radio.startListening();
  
  Serial.print("Terminal A> ");
}