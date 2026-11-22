@echo off
chcp 65001 >nul
title Instalación de Phalanx en Windows
cd /d "%~dp0bin"
phalanx.exe --install
echo.
echo Presione cualquier tecla para salir...
pause >nul
