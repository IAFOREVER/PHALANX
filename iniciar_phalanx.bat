@echo off
chcp 65001 >nul
title Phalanx Sovereign DevSecOps Cockpit
cd /d "%~dp0bin"
phalanx.exe %*
