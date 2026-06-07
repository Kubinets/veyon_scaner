@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo Сканирование сети 192.168.1.0/24...
for /L %%a in (1,1,254) do start /b ping 192.168.1.%%a -n 2 >nul

echo Ожидание завершения пингов...
timeout /t 3 >nul

arp -a > arp_table.txt

cls
echo ============================================================
echo   IP-адрес          MAC-адрес
echo ============================================================

set "mac1=f4-b5-20-5a-47-dc"
set "mac2=f4-b5-20-5a-44-f7"
set "mac3=f4-b5-20-5a-3a-24"
set "mac4=f4-b5-20-59-41-e3"
set "mac5=f4-b5-20-5a-47-f6"
set "mac6=f4-b5-20-5a-48-3d"
set "mac7=f4-b5-20-5a-47-fd"
set "mac8=f4-b5-20-5a-46-97"

for /L %%i in (1,1,8) do (
    set "current_mac=!mac%%i!"
    set "found_ip="
    for /f "tokens=1,2" %%a in ('findstr /i "!current_mac!" arp_table.txt') do (
        set "found_ip=%%a"
    )
    if defined found_ip (
        set "ip=!found_ip!"
        set "mac=!current_mac!"
        set "ip_padded=!ip!                    "
        set "mac_padded=!mac!                    "
        echo !ip_padded:~0,18! !mac_padded:~0,18!
    ) else (
        set "mac=!current_mac!"
        set "msg=[Не найден]"
        set "msg_padded=!msg!                    "
        set "mac_padded=!mac!                    "
        echo !msg_padded:~0,18! !mac_padded:~0,18!
    )
)

echo ============================================================
del arp_table.txt >nul
echo.
pause