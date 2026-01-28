@echo off
:: Limpia archivos temporales y cachés en Windows
echo Iniciando limpieza de archivos temporales...

:: Elimina archivos temporales del sistema
del /q /f /s "%TEMP%\*"

:: Elimina archivos temporales del usuario
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*
"

:: Limpia la caché del navegador (Ejemplo para Google Chrome)
echo Limpiando caché de Google Chrome...
del /q /f /s "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache\*"

:: Elimina archivos de historial de navegación (Ejemplo para Google Chrome)
echo Eliminando historial de navegación de Google Chrome... 
del /q /f /s "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History"

:: Limpia la caché de Microsoft Edge
echo Limpiando caché de Microsoft Edge...
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*"

:: Elimina archivos de historial de navegación (Ejemplo para Microsoft Edge)
echo Eliminando historial de navegación de Microsoft Edge...
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\History"

:: Limpia la caché de Mozilla Firefox
echo Limpiando caché de Mozilla Firefox...
del /q /f /s "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*.default-release\cache2\*"

:: Elimina archivos de historial de navegación (Ejemplo para Mozilla Firefox)
echo Eliminando historial de navegación de Mozilla Firefox...
del /q /f /s "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*.default-release\places.sqlite"

:: Elimina archivos de registro innecesarios
echo Eliminando archivos de registro innecesarios...
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.log"

:: Elimina archivos de prefetch antiguos
echo Eliminando archivos de prefetch antiguos...
del /q /f /s "%systemroot%\Prefetch\*"

:: Elimina archivos de miniaturas
echo Eliminando archivos de miniaturas...
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"

:: Elimina archivos de informes de errores
echo Eliminando archivos de informes de errores...
del /q /f /s "%LOCALAPPDATA%\CrashDumps\*"

:: Elimina archivos de actualizaciones antiguas de Windows
echo Eliminando archivos de actualizaciones antiguas de Windows...
del /q /f /s "%systemroot%\SoftwareDistribution\Download\*"

:: Elimina archivos de instalación temporales de Windows
echo Eliminando archivos de instalación temporales de Windows...
del /q /f /s "%systemroot%\Temp\*"

:: Elimina archivos de caché de fuentes
echo Eliminando archivos de caché de fuentes...
del /q /f /s "%systemroot%\ServiceProfiles\LocalService\AppData\Local\FontCache\*"

:: Elimina archivos de caché de iconos
echo Eliminando archivos de caché de iconos...
del /q /f /s "%USERPROFILE%\AppData\Local\IconCache.db"

:: Elimina archivos de caché de DNS
echo Eliminando caché de DNS...
ipconfig /flushdns

:: Elimina archivos de historial de navegación (Ejemplo para Google Chrome)
echo Eliminando historial de navegación de Google Chrome... 
del /q /f /s "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History"

:: Limpia la papelera de reciclaje
echo Vaciando la papelera de reciclaje...
rd /s /q "%systemdrive%\$Recycle.Bin"

echo Limpieza completada.
pause
