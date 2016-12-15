; Grand Theft Auto 5 Hotkey by PhantomGamers
; Provides hotkeys for opening snack menu, eating snacks, equipping armor, entering passive mode,
; retrieving vehicles, and quick restarting the game.

; Thanks to twentyafterfour for original script
; Updated 2016-07-19

; <Environment Setup>
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability. Breaks in GTA
#SingleInstance Force ; Ensures only one instance of the script is running.
SetTimer, reloadScript, 90000
; </Environment Setup>

; <Assign Hotkey and Delay Values>
IniRead, AutoHealthKey, GTA5HK.ini, Controls, AutoHealthKey, F24
IniRead, HealthMenuKey, GTA5HK.ini, Controls, HealthMenuKey, F24
IniRead, AutoArmorKey, GTA5HK.ini, Controls, AutoArmorKey, F24
IniRead, togglePassiveKey, GTA5HK.ini, Controls, togglePassiveKey, F24
IniRead, RetrieveCarKey, GTA5HK.ini, Controls, RetrieveCarKey, F24
IniRead, restartGTAKey, GTA5HK.ini, Controls, restartGTAKey, F24
IniRead, statusTestKey, GTA5HK.ini, Controls, statusTestKey, F24
IniRead, switchMaskKey, GTA5HK.ini, Controls, switchMaskKey, F24
IniRead, switchScarfKey, GTA5HK.ini, Controls, switchScarfKey, F24
IniRead, becomeCEOKey, GTA5HK.ini, Controls, becomeCEOKey, F24
IniRead, gameVersion, GTA5HK.ini, Controls, gameVersion, 2
IniRead, gameID, GTA5HK.ini, Controls, gameID, 0

; <Hotkey Code Section>
Hotkey, IfWinActive, ahk_class grcWindow ; Disables hotkeys when alt-tabbed or GTA is closed.
; Assigns above values to hotkeys. Do not change these lines.
Hotkey, %AutoHealthKey%, AutoHealth
Hotkey, %HealthMenuKey%, HealthMenu
Hotkey, %AutoArmorKey%, AutoArmor
Hotkey, %togglePassiveKey%, PassiveMode
Hotkey, %RetrieveCarKey%, RetCar
Hotkey, %restartGTAKey%, RestartGTA
Hotkey, %statusTestKey%, HKTest
Hotkey, %switchMaskKey%, maskItUp
Hotkey, %switchScarfKey%, scarfItUp
Hotkey, %becomeCEOKey%, becomeCEO

setkeydelay, 25, 5  ; Sets delay(ms) between keystrokes issued. Arguments are delay between keystrokes and press duration, respectively.
; They might be able to go lower but these values are pretty fast and work reliably.
return
; </Hotkey Code Section>

; <Macro Code Section>

; <AutoHealth>
; Eats two snacks out of second snack slot automatically.
AutoHealth:
Send {m}
sleep, 120
If GetKeyState("ScrollLock", "T")
	Send {Down}
Send {Down}{Enter}{Down}{Down}{Enter}
Send {Down}{Enter}{Enter}{m}
return
; </AutoHealth>

; <HealthMenu>
; Opens up your snack mnenu for manual selection of snacks.
HealthMenu:
Send {m}
sleep, 120
If GetKeyState("ScrollLock", "T")
	Send {Down}
Send {Down}{Enter}{Down}{Down}{Enter}
return
; </HealthMenu>

; <AutoArmor>
; Equips super heavy armor automatically.
AutoArmor:
Send {m}
sleep, 120
If GetKeyState("ScrollLock", "T")
	Send {Down}
Send {Down}{Enter}{Down}{Enter}
Send {Down}{Down}{Down}{Down}{Enter}{m}
return
; </AutoArmor>

; <PassiveMode>
; Toggles passive mode on or off.
PassiveMode:
Send {m}
sleep, 120
Send {Up}{Enter}{m}
return
; </PassiveMode>

; <RetCar>
; Requests delivery of personal vehicle.
RetCar:
Send {m}
sleep, 120
If GetKeyState("ScrollLock", "T")
	Send {Down}
Send {Down}{Down}{Down}{Enter}{Enter}{m}
return
; </RetCar>

; <becomeCEO>
; Becomes a CEO.
becomeCEO:
If not GetKeyState("ScrollLock", "T") {
	Send {m}
	sleep, 120
	Send {Down}{Down}{Down}{Down}{Down}{Down}{Enter}{Enter}{Enter}
	SetScrollLockState, On
	return
}

Send {m}
sleep, 120
Send {Enter}{Up}{Enter}{Enter}
SetScrollLockState, Off
return
; </becomeCEO>

; <maskItUp>
; Equips the second to the right mask, in order to trigger the armor glitch.
maskitUp:
Send {m}
sleep, 120
If GetKeyState("ScrollLock", "T")
	Send {Down}
Send {Down}{Down}{Enter}{Down}{Enter}{Down}{Down}{Down}{Right}{Right}{Right}{m}
return
; </maskItUp>

; <scarfItUp>
; Equips and unequips a scarf. Same as maskItUp.
scarfitUp:
Send {m}
sleep, 120
If GetKeyState("ScrollLock", "T")
	Send {Down}
Send {Down}{Down}{Enter}{Down}{Enter}{Up}{Up}{Up}{Up}{Right}{Left}{m}
return
; </scarfItUp>

; <RestartGTA>
; Quickly terminates the GTA processes and restarts the game. Useful for exploits.
RestartGTA:
Process, Close, GTAVLauncher.exe
Process, Close, GTA5.exe
FileDelete, %A_AppData%\..\Local\Rockstar Games\GTA V\in-* ; Prevents safemode warning
sleep, 3000
if (gameVersion = 0) 
{
	Run steam://rungameid/271590 
} else if (gameVersion = 1) 
{ 
	Run steam://rungameid/%gameID% 
}
return
; </RestartGTA>

; <HotkeyTest>
; Use to confirm hotkeys are functional without doing anything.
HKTest:
SoundBeep
return
; </HotkeyTest>

;</Macro Code Section>

reloadScript:
Process, Exist, gta5.exe
if (ErrorLevel != 1)
	Reload
return