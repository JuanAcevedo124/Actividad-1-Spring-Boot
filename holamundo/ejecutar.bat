@echo off
chcp 65001 >nul
title holamundo - Spring Boot
cd /d "%~dp0"
echo ===============================================
echo  Arrancando holamundo en http://localhost:8080
echo  Endpoints: /api/hola /saludo /config /bean
echo  Para detener: cierra esta ventana o pulsa Ctrl+C
echo ===============================================
"C:\Program Files\Eclipse Adoptium\jdk-21.0.12.101-hotspot\bin\java.exe" -jar "target\holamundo-0.0.1-SNAPSHOT.jar"
pause
