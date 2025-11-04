echo off
echo ==========================================
echo        SYSTEM INFORMATION REPORT
echo ==========================================

echo .
echo Current Date: $(date)
echo .

echo ------------------------------------------
echo List of Running Processes:
echo ------------------------------------------
ps -ef

echo ------------------------------------------
echo System Info:
echo ------------------------------------------
neofetch

echo .
echo ==========================================
echo Report Generated Successfully.
echo ==========================================

exit
