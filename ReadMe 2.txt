This repo shows two possibilities to share REaScript data with the outside world.

The first one uses JSFX to connect to a JS plugin where a two way connection is implemented.
The JS plugin also reads and writes from/to its midi in/out devices. 

The Second one uses TCP to connect to a server connection, again creating a (robust!) two way connection.
For this an example TCP server is supplied.

Two examples are included, which shows the ways I use these frameworks.

The first example is a simple MIDITHrough, the second is an example which monitors parameter and program changes
and performs someextra commands. If you just want to see how things work, I'd suggest to look at MIDIThrough.

Both examples attach to a framework (JSFX based or TCP based).
There are only TWO calls available, namely:

1. fwInitialize(setup,loop,onValueIn)
2. function ValueOut

1. fwInitialize should be called at the beginning of your program. The three parameters are function which will be called:
- Setup will be called as first
- Loop will be called repeatedly.
- onValueIn will be called if the framework has received a 24 bit value.
  This normally will be a MIDI event, or a midi SysEx event.

2. Your application can react to these events, and moreover can send data to the framework output, using ValueOut (again, 24 bits).
See the example code for more.

(OK, there's one more function: FrameworkRunning, which you can call to verify if the Framework is Running, that is, that 
the JSFXBridge is loaded or that a TCP ServerConnection is established) 

To attach to the JSFX framework you should include JSFXFramework:

@import ../JSFXFramework.eel

To attach to the TCP framework you should include TCPFrameworkL

@import ../TCPFramework.eel

That's all, folks!




  
  




