@echo off
cd /d "%~dp0"

echo Bringing stack down...
docker compose down --remove-orphans
IF %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

echo Pulling latest images...
docker compose pull
IF %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

echo Starting fresh stack...
docker compose up -d
IF %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

REM ----------------------------------------------------
REM 5. Clean up dangling (<none>) images to free disk
REM ----------------------------------------------------
echo Pruning dangling images...
docker image prune -f
IF %ERRORLEVEL% NEQ 0 (
    echo [WARN] Prune failed — continuing anyway.
)

echo -----------------------------------------------
echo Done! Stack refreshed and old images removed.
echo -----------------------------------------------
pause
