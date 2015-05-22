**Version 0.1** - Basic functionality

![alt-text](http://i.imgur.com/VFubQjGh.png, "SoCal Force x HK Army present: PB Playbook")

* XCode 6.3 / Swift 1.2
* iOS 8.0
* Parse/Swift (not using Obj-C library)

**PB Playbook** is an app made to revolutionize the way we play competitive paintball. Every other competitive sport utilizes statistics heavily in the way they approach the game. 
* In football: defenses run specific coverage-schemes based on wide-reciever personal
* In baseball: a manager might put in a right-handed batter who has a high on-base percentage against left-handed pitchers
* etc etc

**PB Playbook** wants to bring that same usage of data to paintball. At its most basic level (right now) this app call tell which teams go to what bunkers at varying levels of every game. Later (very soon) iterations will provide player data such as survivability, bunker choices and run-and-gun ability. Here is a use case that we already saw in much earlier versions of the app.
* At PSP Dalls in 2015, San Antonio X-Factor had two primary snake players: Carl Markowski and Billy Bernnachia. When Carl was in, X-Factor went to the snake off the break 100% of the time. Billy, on the other hand, went to the snake only 12% of the time and stopped at the god 80% of the time (the remaining 8% he went to the corner). Knowing this information drastically changes the lanes that a team should shoot off the break. If Carl is in, shoot the gap between the god and the snake-one. If Billy is in, shoot the gap between the california and the god.

## Building the test app
Until we're production ready, everything should go through the simulator. The XCode simulator still connects to the Parse database, so we're recording data, but we're not on-iPad ready yet. To do this

1. Clone the repo `git clone https://github.com/das3in/pbPlaybook.git`
2. Open `PBPlaybook.xcodeproj`
3. In the top-left, change the active scheme from `iPhone 6` to `iPad 2`
4. Press the play button and watch the magic happen

## Usage - ToDo
Put up some cool pictures and stuff of app usage

## App - ToDo's

1. Re-enable double-click for bunkerDetail functionality
2. Make data slides
3. Re-write Parse queries so I'm not querying at every segue
4. Facebook integration
5. Divisional teams (gotta find/create some sort of tournament registration api)
6. Make it pretty
