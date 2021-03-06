@echo off
cd "%~dp0"
set version-suffix=%1

cd BlazorContextMenu
call "node_modules\.bin\gulp.cmd" all
cd "%~dp0"

dotnet build BlazorContextMenu.sln -c Release
if %errorlevel% neq 0 exit /b %errorlevel%

dotnet test BlazorContextMenu.E2ETests -c Release --no-build 
if %errorlevel% neq 0 exit /b %errorlevel%

dotnet pack BlazorContextMenu -c Release --no-build /p:VersionSuffix="%version-suffix%" -o bin\nuget
if %errorlevel% neq 0 exit /b %errorlevel%