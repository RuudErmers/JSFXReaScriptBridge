This is a set of files which enables a bridge between JFSX and ReaScript.
It is for use in Reaper.
The main use is to communicate between a JSFX plugin and a ReaScript.
I was not able to find a solution for that so I build this.
See e.g. this thread http://forum.cockos.com/showthread.php?t=155018

To get things working, here is an example where MIDI input is read by the JSFX bridge and is send to 
a ReaScript "MidiThrough". This Reascript sends some modified data to JSFX Bridge which outputs this over Midi.

Here's step-by-step instructions:

1. Start with a new Reaper project and insert a new track with the JS Plugin: ReasJSFXBridge
2. Now open the ReaScript MidiThrough.
3. From a keyboard, or the Virtual Keyboard write some MIDI data to the track. 
4. When monitoring the output, you will see (hopefully) some modified Midi data.

Note: JSFXBridge must be the first plugin on the First track. 

I will explain a bit of the code in a minute, but first the API:

1. ReasJSFXBridge: 

You can send and receive values to a Reascript. Values should be at most 24 bits integer.
Send:    Call ReaSOut(value)
Receive: If ReasJSFXBridge receives data from a ReaScript it calls: ReaSIn
MidiReceive: If ReasJSFXBridge receives mididata it calls: midiIn  (Note that it ets all incoming midi events)
MidiSend:    You can send midi using midiOut (offcourse, this is trivial, but this way, the API is complete)

The script itself is a bit blurry due to the nature of JSFX plugins. Please examine the part between AppStart and AppEnd.
In the supplied example, also midiSysEx is implemented, but that is just an example use

2. MidiThrough.eel

Uses a small frameworks, which hides all communication details.
To initialize the framework, call fwInitialize:

// to use the framework, call fwInitialize with 3 function callbacks:
// 1. setup()
// 2. loop()       // in this case: empty
// 3. JSFXIn(value)

fwInitialize("setup","","onJSFXIn");

setup,     will be called once at startup.
loop,      will be called repeatedly, 
onJSFXIn,  will be called if there is a message from the ReasJSFXBridge)

the three arguments are strings which name the function to be called. It may be an empty string.

the framework has one more function, called

JSFXOut,   which writes a value to the ReasJSFXBridge

==========================================================================

The code: 

Communication is achieved using the Sliders interface. This works remarkably  fast.
Both parts also use an extra ringbuffer of 256 bytes. Since you have the source you can easily adjust this to your needs.
Both parts place the ringbuffer at address 1000, so don't use that.
In my example I also use a SysEx buffer starting from 2000 (in ReasJSFXBridge code only).

I am new to EEL and am more used to C, so therefore I may have solved some things (like callback function) somewhat oddly.
The part with the sliders code in ReasJSFXBridge (getSlider/setSlider) is pretty ugly/stupid, but I have not investedd time to get a better solution. 
If you have remarks please mail them!

(Note: I will not maintain this repo, it is for startcode only...)
 







 

