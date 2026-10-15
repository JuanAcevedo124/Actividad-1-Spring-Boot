@echo off
chcp 65001 >nul
echo Probando endpoints...
echo.
echo --- GET /api/hola ---
curl.exe -s http://localhost:8080/api/hola
echo.
echo --- GET /saludo ---
curl.exe -s http://localhost:8080/saludo
echo.
echo --- GET /config ---
curl.exe -s http://localhost:8080/config
echo.
echo --- GET /bean ---
curl.exe -s http://localhost:8080/bean
echo.
echo.
pause
