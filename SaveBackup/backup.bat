@echo off
chcp 65001 > nul
setlocal

rem 设置存档路径和备份路径（默认值）
rem set "archive_path="
rem set "backup_path="

rem 从.ini文件中读取archive_path和backup_path的值
for /f "usebackq tokens=1,* delims==" %%A in ("backup.ini") do (
    rem 检查当前行是否是archive_path或backup_path
    if "%%A"=="archive_path" (
        set "archive_path=%%B"
    ) else if "%%A"=="backup_path" (
        set "backup_path=%%B"
    )
)


rem 校验存档路径是否存在
if not exist "%archive_path%\" (
    echo 存档路径不存在。
    pause
    exit /b 1
)

rem 校验备份路径是否存在
if not exist "%backup_path%\" (
    echo 备份路径不存在。
    pause
    exit /b 1
)

rem 获取当前日期和时间作为文件夹名称（格式：YYYY-MM-DD_HH-MM-SS）
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "datetime=%%I"
set "datetime=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%"

rem 创建包含日期和时间信息的文件夹
set "backup_folder=%backup_path%\Backup_%datetime%"
mkdir "%backup_folder%"

rem 复制存档路径下的所有文件和文件夹到备份文件夹中（覆盖已存在的文件夹）
xcopy /s /e /y "%archive_path%\*" "%backup_folder%"

echo "备份完成。"

pause

endlocal