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
isCEO := 0 ; Hacky CEO toggle
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
IniRead, AutoClick, GTA5HK.ini, Controls, AutoClick, F24
IniRead, toggleCEOMode, GTA5HK.ini, Controls, toggleCEOMode, F24

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
Hotkey, %AutoClick%, AutoClick
Hotkey, %toggleCEOMode%, toggleCEOMode

SetKeyDelay, 25, 5  ; Sets delay(ms) between keystrokes issued. Arguments are delay between keystrokes and press duration, respectively.
; They might be able to go lower but these values are pretty fast and work reliably.
SetMouseDelay, 25
Return
; </Hotkey Code Section>

; <Macro Code Section>

; <AutoHealth>
; Eats two snacks out of second snack slot automatically.
AutoHealth:
Send {m}
Sleep, 120
If (isCEO)
	Send {Down}
Send {Down}{Enter}{Down}{Down}{Enter}
Send {Down}{Enter}{Enter}{m}
Return
; </AutoHealth>

; <HealthMenu>
; Opens up your snack mnenu for manual selection of snacks.
HealthMenu:
Send {m}
Sleep, 120
If (isCEO)
	Send {Down}
Send {Down}{Enter}{Down}{Down}{Enter}
Return
; </HealthMenu>

; <AutoArmor>
; Equips super heavy armor automatically.
AutoArmor:
Send {m}
Sleep, 120
If (isCEO)
	Send {Down}
Send {Down}{Enter}{Down}{Enter}
Send {Down}{Down}{Down}{Down}{Enter}{m}
Return
; </AutoArmor>

; <PassiveMode>
; Toggles passive mode on or off.
PassiveMode:
Send {m}
Sleep, 120
Send {Up}{Enter}{m}
Return
; </PassiveMode>

; <RetCar>
; Requests delivery of personal vehicle.
RetCar:
Send {m}
Sleep, 120
If (isCEO)
	Send {Down}
Send {Down}{Down}{Down}{Enter}{Enter}{m}
Return
; </RetCar>

; <becomeCEO>
; Becomes a CEO.
becomeCEO:
If (!isCEO) 
{
	Send {m}
	Sleep, 120
	Send {Down}{Down}{Down}{Down}{Down}{Down}{Enter}{Enter}{Enter}
	Goto toggleCEOMode
	Return
}

Send {m}
Sleep, 120
Send {Enter}{Up}{Enter}{Enter}
Goto toggleCEOMode
Return
; </becomeCEO>

; <maskItUp>
; Equips the second to the right mask, in order to trigger the armor glitch. Will only work in heists.
; In modes other than heists this will switch helmets instead.
maskitUp:
Send {m}
Sleep, 120
If (isCEO)
	Send {Down}
Send {Down}{Down}{Enter}{Down}{Enter}{Down}{Down}{Down}{Down}{Right}{Right}{Right}{m}
Return
; </maskItUp>

; <scarfItUp>
; Equips and unequips a scarf. Same as maskItUp.
scarfitUp:
Send {m}
Sleep, 120
If (isCEO)
	Send {Down}
Send {Down}{Down}{Enter}{Down}{Enter}{Up}{Up}{Up}{Up}{Right}{Left}{m}
Return
; </scarfItUp>

; <RestartGTA>
; Quickly terminates the GTA processes and restarts the game. Useful for exploits.
RestartGTA:
Process, Close, GTAVLauncher.exe
Process, Close, GTA5.exe
FileDelete, %A_AppData%\..\Local\Rockstar Games\GTA V\in-* ; Prevents safemode warning
Sleep, 3000
If (gameVersion = 0) 
{
	Run steam://rungameid/271590 
} Else If (gameVersion = 1) 
{ 
	Run steam://rungameid/%gameID% 
}
Return
; </RestartGTA>

; <AutoClick>
; Automatically click your mouse. Useful for collecting money in Pacific Standard.
; Also works for rapid firing semi-automatic weapons.
AutoClick:
Loop
{
	Send {LButton}
	If (GetKeyState(AutoClick, "P")=0)
		Break
}
Return
; </AutoClick>

; <toggleCEOMode>
; Toggles whether or not the script should expect you to be CEO.
toggleCEOMode:
isCEO := !isCEO
Return

; <HotkeyTest>
; Use to confirm hotkeys are functional without doing anything.
HKTest:
SoundBeep
Return
; </HotkeyTest>		

;</Macro Code Section>						

reloadScript:
Process, Exist, gta5.exe
If (ErrorLevel != 1)
	Reload
Return