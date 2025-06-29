# Novastudios_Commands
A Simple Command Script with Loads of Commands.


Features
/car [model] — Spawn a vehicle by model name.

/fix — Fix your current vehicle.

/revive — Revive yourself if dead.

/dv — Delete the vehicle you are in.

/heal — Restore your health to full.

/clearchat — Clear your chat (requires command.clearchat ACE permission).

/kill — Kill yourself.

/coords — Show your current coordinates.

/id — Display your server ID.

/time — Show the current in-game time.

/me [text] — Roleplay action message.

/do [text] — Roleplay descriptive message.

/tweet [text] — Send a Twitter-style message.

/ooc [text] — Send an out-of-character message.

Installation
Download or clone this resource into your server's resources folder.

Edit server.lua and replace the Discord webhook URL (webhook variable) with your own webhook URL.

Add this line to your server.cfg to start the resource:

ensure fivem-simple-commands
Restart your server or start the resource manually.

Permissions:
The /clearchat command requires the ACE permission: command.clearchat.

You can grant it in your server config or server.cfg like so:


add_ace group.admin command.clearchat allow
Replace group.admin with the group you want.

Notes:
Make sure your Discord webhook URL is valid for logging.


