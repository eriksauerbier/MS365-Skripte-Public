rem Skript f�r die Migration des Outlook-Profils von OnPrem Exchange zu MS365
rem Stannek GmbH v.1.0 - 22.03.2022 - E.Sauerbier

rem Parameter

SET OutlookPath="C:\Program Files (x86)\Microsoft Office\root\Office16\Outlook.exe"
SET OSTPath1="%LocalAppData%\Microsoft\Outlook\*OST"
SET OSTPath2="%HomeDrive%\Outlook\*OST"
SET OutlookORGProfilePath="HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles"
SET OutlookCopyProfilePath="HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles.OnPREM"

rem Outlook starten um aktuelle Einstellungen zu pr�fen

call %OutlookPath% 

pause

rem vorhandene OST-Dateien suchen und l�schen

if Exist %OSTPath1% (del %OSTPath1%)
if Exist %OSTPath2% (del %OSTPath2%)

pause

rem Outlook-Profil l�schen

reg copy %OutlookORGProfilePath% %OutlookCopyProfilePath% /s
reg Delete %OutlookORGProfilePath% /f

pause

rem AnmeldeInformationen l�schen

control keymgr.dll

pause

rem Outlook starten

call %OutlookPath% 
