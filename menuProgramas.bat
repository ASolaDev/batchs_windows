@echo off
setlocal

rem -- Rutas: sustituir por las rutas reales a cada .exe
set "P1=C:\vDos\PROG\GESTION\CONTA\CONTA.EXE"
set "P2=C:\vDos\PROG\GESTION\FACTU\FACTU.EXE"
set "P3=C:\vDos\PROG\CARJESUS\GESTION\CONTA\CONTA.EXE"
set "P4=C:\vDos\PROG\CARJESUS\GESTION\FACTU\FACTU.EXE"

:menu
cls
echo ==============================
echo     MENU - Ejecutar Programas
echo ==============================
echo 1) EMPRESAS MÚLTIPLES - CONTA
echo 2) EMPRESAS MÚLTIPLES - FACTU
echo 3) CARJESUS - CONTA
echo 4) CARJESUS - FACTU
echo X) Salir
echo.
set /p "opt=Seleccione una opcion [1-9,0=10,X]: "

if /I "%opt%"=="X" goto :fin
if "%opt%"=="1" start "" "%P1%" & goto menu
if "%opt%"=="2" start "" "%P2%" & goto menu
if "%opt%"=="3" start "" "%P3%" & goto menu
if "%opt%"=="4" start "" "%P4%" & goto menu

echo Opcion invalida.
pause
goto menu

:fin
endlocal
exit /b 0