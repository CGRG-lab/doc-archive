@REM https://stackoverflow.com/questions/1794547/how-can-i-make-an-are-you-sure-prompt-in-a-windows-batchfile
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=This will update docsy, are you sure (Y/[N])? 
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

echo Update...
@REM https://www.docsy.dev/docs/updating/
git submodule update --remote
pause

:END
endlocal
