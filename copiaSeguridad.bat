@echo off
setlocal enabledelayedexpansion
title Copia de Seguridad
color 0a

set "destino_raiz=D:\CopiaSeguridad"
set "fecha=%date:~-4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%"
set "carpeta_backup=%destino_raiz%\backup_%fecha%"
set "log_file=%destino_raiz%\logs\backup_%fecha%.log"

set "origen1=%USERPROFILE%\Documents"
set "origen2=%USERPROFILE%\Pictures"
set "origen3=%USERPROFILE%\Videos"
set "origen4=%USERPROFILE%\Music"

if not exist "%destino_raiz%" (
    echo ERROR: Destino no existe: %destino_raiz%
    pause
    exit /b 1
)

if not exist "%destino_raiz%\logs" mkdir "%destino_raiz%\logs"

echo [%date% %time%] Iniciando copia de seguridad >> "%log_file%"
echo Iniciando copia de seguridad en %carpeta_backup%...
echo ---------------------------------------------------

set "error_count=0"

for %%a in ("%origen1%" "%origen2%" "%origen3%" "%origen4%") do (
    if not exist "%%~a" (
        echo ADVERTENCIA: No existe %%~a >> "%log_file%"
        echo ADVERTENCIA: No existe %%~a
        set /a error_count+=1
    ) else (
        echo Copiando: %%~nxa...
        echo [%date% %time%] Copiando %%~nxa >> "%log_file%"
        robocopy "%%~a" "%carpeta_backup%\%%~nxa" /E /Z /R:3 /W:5 /MT:8 /FFT /XJ /NP >> "%log_file%"
        if errorlevel 1 set /a error_count+=1
    )
)

echo ---------------------------------------------------
echo [%date% %time%] Proceso completado. Errores: %error_count% >> "%log_file%"

if %error_count% gtr 0 (
    color 0c
    echo Completado CON ERRORES. Revisar: %log_file%
) else (
    color 0a
    echo Proceso completado exitosamente.
)

echo.
echo Log guardado en: %log_file%
pause