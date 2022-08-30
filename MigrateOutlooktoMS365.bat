rem Skript f�r die Migration des Outlook-Profils von OnPrem Exchange zu MS365
rem Stannek GmbH v.1.3.1 - 29.08.2022 - E.Sauerbier

rem Parameter

SET OutlookPath="C:\Program Files (x86)\Microsoft Office\root\Office16\Outlook.exe"
SET OSTPath1="%LocalAppData%\Microsoft\Outlook\*OST"
SET OSTPath2="%HomeDrive%\Outlook\*OST"
SET OutlookORGProfilePath="HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles"
SET OutlookCopyProfilePath="HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles.OnPREM"
SET OutlookAutoDicoverPath="HKCU\Software\Microsoft\Office\16.0\Outlook\Autodiscover"
SET OutlookSettingsPath="HKCU\Software\Microsoft\Office\Outlook\Settings"

rem Outlook starten um aktuelle Einstellungen zu pr�fen

call %OutlookPath% 

pause

rem vorhandene OST-Dateien suchen und l�schen

if Exist %OSTPath1% (del %OSTPath1%)
if Exist %OSTPath2% (del %OSTPath2%)

pause

rem Outlook-Profil und Einstellungen l�schen

reg copy %OutlookORGProfilePath% %OutlookCopyProfilePath% /s
reg Delete %OutlookORGProfilePath% /f
reg Delete %OutlookSettingsPath% /f

pause

rem AutoDiscover Einstellung zur�cksetzen

reg Delete %OutlookAutoDicoverPath% /f

rem DATEV Office-Einstellung zur�cksetzen

regedit /S "%DATEVPP%\PROGRAMM\BSOffice\Service auf die Datei SetOfficeAdapterToDefault_ALL.reg"

rem AnmeldeInformationen l�schen

control keymgr.dll

pause

rem Outlook starten

call %OutlookPath% 
