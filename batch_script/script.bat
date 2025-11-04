@echo off
echo ==========================================
echo        SYSTEM INFORMATION REPORT
echo ==========================================

echo.
echo Current Date: %date%
echo Current Time: %time%
echo.

echo ------------------------------------------
echo List of Running Processes:
echo ------------------------------------------
tasklist

echo ------------------------------------------
echo System Info:
echo ------------------------------------------
fastfetch

echo.
echo ==========================================
echo Report Generated Successfully.
echo ==========================================

pause
