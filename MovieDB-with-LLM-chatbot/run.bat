@echo off
REM Starts MovieBot (Spring Boot).   run.bat           -> PostgreSQL (default)
REM                                  run.bat h2        -> in-memory H2 database
setlocal
cd /d "%~dp0"

where java >nul 2>nul
if errorlevel 1 (
  echo [!] Java not found. Install JDK 17 or newer from https://adoptium.net and reopen this window.
  pause
  exit /b 1
)

set "MVN=mvn.cmd"
where mvn.cmd >nul 2>nul
if errorlevel 1 set "MVN=%~dp0.tools\apache-maven-3.9.9\bin\mvn.cmd"
if not "%MVN%"=="mvn.cmd" if not exist "%MVN%" (
  echo Maven not found - downloading a private copy into .tools ...
  if not exist .tools mkdir .tools
  curl -fL -o .tools\maven.zip https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip
  if errorlevel 1 goto :dlfail
  tar -xf .tools\maven.zip -C .tools
  if errorlevel 1 goto :dlfail
  del .tools\maven.zip
)

set "PROFILE="
if /i "%~1"=="h2" (
  set "PROFILE=-Dspring-boot.run.profiles=h2"
)

echo.
echo  Starting MovieBot... the first run downloads dependencies and can take a few minutes.
echo  When you see "Started MovieAgentApplication", open  http://localhost:8080
echo.
call "%MVN%" spring-boot:run %PROFILE%
pause
exit /b 0

:dlfail
echo [!] Could not download Maven. Install it manually, or open the project in Spring Tool Suite / IntelliJ.
pause
exit /b 1
