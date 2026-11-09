@echo off
chcp 65001 >nul
title Dalli Klick - Spielstart

echo ========================================================
echo        DALLI KLICK - Das Bilderrätsel Spiel
echo ========================================================
echo Starte lokalen Server und öffne Spiel im Browser...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1"

pause
