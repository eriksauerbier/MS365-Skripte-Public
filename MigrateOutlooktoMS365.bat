rem Skript f�r die Migration des Outlook-Profils von OnPrem Exchange zu MS365
rem Stannek GmbH v.1.11 - 08.08.2022 - E.Sauerbier

rem #########
rem Parameter

SET OutlookPath="C:\Program Files (x86)\Microsoft Office\root\Office16\Outlook.exe"
SET OSTPath1="%LocalAppData%\Microsoft\Outlook\*OST"
SET OSTPath2="%HomeDrive%\Outlook\*OST"
SET OutlookRegPath="HKCU\Software\Microsoft\Office\16.0\Outlook"
SET OutlookRegCopyPath="HKCU\Software\Microsoft\Office\16.0\Outlook.Old"
SET OutlookORGProfilePath="HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles"
SET OutlookCopyProfilePath="HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles.OnPREM"
SET OutlookAutoDicoverPath="HKCU\Software\Microsoft\Office\16.0\Outlook\Autodiscover"
rem #########

rem #####################################
rem Outlook starten um aktuelle Einstellungen zu pr�fen, Zeile bei Bedarf auskommentieren

rem call %OutlookPath% 

rem pause

rem #####################################
rem vorhandene OST-Dateien suchen und l�schen

if Exist %OSTPath1% (del %OSTPath1%)
if Exist %OSTPath2% (del %OSTPath2%)

pause

rem #####################################
rem AutoDiscover Einstellung zur�cksetzen

reg Delete %OutlookAutoDicoverPath% /f

rem #####################################
rem Outlook-Profil l�schen oder den komplette Outlook-Einstellungenen inkl. Profile l�schen
rem Entsprechend auskommentieren

rem komplette Outlook-Einstellungenen inkl. Profile 
reg copy %OutlookRegPath% %OutlookRegCopyPath% /s
reg Delete %OutlookRegPath% /f

rem Nur Outlook-Profil
rem reg copy %OutlookORGProfilePath% %OutlookCopyProfilePath% /s
rem reg Delete %OutlookORGProfilePath% /f

pause

rem #####################################
rem AutoDiscover Einstellung zur�cksetzen

reg Delete %OutlookAutoDicoverPath% /f

rem AnmeldeInformationen l�schen

control keymgr.dll

pause

rem ###############
rem Outlook starten

call %OutlookPath% 
