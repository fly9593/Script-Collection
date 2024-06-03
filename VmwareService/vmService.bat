@echo off
chcp 65001 >nul

@REM 定义服务名称列表

set services=VMAuthdService VMnetDHCP "VMware NAT Service" VMUSBArbService VmwareAutostartService

@REM 主菜单

:menu
echo "请选择操作"
echo "[1] 启动vm"
echo "[2] 查看服务状态"
echo "[3] 启动服务"
echo "[4] 停止服务"
echo "[5] 退出"
set /p choice=输入你的选择 (1, 2, 3, 4, 5):

echo 您输入了 %choice% ...

if "%choice%" == "1" goto :start_vm
if "%choice%" == "2" goto :check_status
if "%choice%" == "3" goto :start_services
if "%choice%" == "4" goto :stop_services
if "%choice%" == "5" goto :end

echo 无效选择，请重试。
goto :menu

@REM 函数：查看服务状态

:check_status
echo 检查服务状态...
for %%s in (%services%) do (
    echo 服务 %%s 的状态:
    sc query %%s | findstr /i "STATE"
    echo.
)
goto :menu

@REM 函数：启动服务

:start_services
echo 启动服务...
for %%s in (%services%) do (
    echo 启动 %%s...
    sc start %%s | findstr /i "STATE"
    echo.
)
goto :menu

@REM 函数：停止服务

:stop_services
echo 停止服务...
for %%s in (%services%) do (
    echo 停止 %%s...
    sc stop %%s | findstr /i "STATE"
    echo.
)
goto :menu

@REM 函数：启动vm

:start_vm
echo 启动vm
start "" "vmware.exe"
exit /b

:end
echo 退出！
pause
exit /b


