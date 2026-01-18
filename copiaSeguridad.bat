@echo off
title Copia de Seguridad:
color 0a

set "destino_raiz=D:\CopiaSeguridad"

set "carpetas="Carpeta1" "Carpeta2" "Fotos" "Proyectos""

set "origen1=%USERPROFILE%\Documents"
set "origen2=%USERPROFILE%\Pictures"
set "origen3=%USERPROFILE%\Videos"
set "origen4=%USERPROFILE%\Music"

echo Iniciando copia de seguridad en %destino_raiz%...
echo ---------------------------------------------------

for %%a in ("%origen1%" "%origen2%" "%origen3%" "%origen4%") do (
    echo Copiando: %%~nxa...
    robocopy "%%~a" "%destino_raiz%\%%~nxa" /E /Z /R:2 /W:5 /MT:8 /FFT
)

echo ---------------------------------------------------
echo Proceso completado. Puedes extraer el disco de forma segura.
pause