@echo off
echo ***check diskspace total 
call check_diskspace_total
echo Script 1 completed.
echo.
echo Launching Script 2...
call script2.sh
echo Script 2 completed.
echo.