# VSCode
Here are my VSCode settings.

* Settings.json
* Keybinding.json
* psprofile.ps1

## Settings.json
These are my settings with these features:

* Variables are one word (including $) - selection and positioning feature
* MouseWheel zooms
* Handles German Umlaute correctly 
* Active Window defines the document type of a new window
* Colorize borders and title with peacock (if peacock installed)
* Terminal cache up to 5000 lines (needed)
* Git Confirmations disabled
* Testsettings for faster intellisense

## Keybindings.json
These are my Keybindings. Keep in mind, I'm a PowerShell Guy, so the bindings originate at the PowerShell ISE.

* SQL/F5 : Execute all
* SQL/F8 : Execute Line (not perfect for complex SQL code)
* SQL/CRTL+SHIFT+e : Removed execute all
* SQL/CTRL-Q A : Convert lines to SQL Array
* POWERSHELL/CTRL-Q A : Convert lines to PowerShell Array
* MARKDOWN/CTRL-Q A : Convert lines to PowerShell Array

## psprofile.ps1

* Set-Module path (to shorten modulepathes)
* Startup
    + User and Computer are displayed at startup
    + Date and Time are displayed at startup
* Prompt
    + Timestamp in prompt
    + Timespan of the last command in prompt
    + Prompt in red for "as admin"
    + Prompt color depends on PowerShell Provider

