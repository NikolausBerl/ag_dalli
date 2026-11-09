@echo off
chcp 65001 >nul
title Bilderliste aktualisieren

echo ========================================================
echo   Dalli Klick - Bilderliste aktualisieren
echo ========================================================
echo Scanne Ordner "bilder" und erstelle bilder.js...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0bilder_aktualisieren.ps1"

echo.
echo Fertig! Du kannst index.html jetzt direkt öffnen.
pause
