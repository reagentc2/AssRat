@echo off
:: File: taskmgr_watchdog.bat

:: Enable Task Manager if disabled
:check
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" >nul 2>&1
if %errorlevel%==0 (
    for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" 2^>nul') do (
        if "%%a"=="0x1" (
            echo Task Manager is disabled. Re-enabling...
            reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /f
        )
    )
)

:: Sleep for 60 seconds before checking again
timeout /t 60 /nobreak >nul
goto check
