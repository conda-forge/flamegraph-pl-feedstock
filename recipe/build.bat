@echo off
setlocal enabledelayedexpansion

if not exist "%PREFIX%\Library\bin" (
    mkdir "%PREFIX%\Library\bin"
)

:: Install the main flamegraph generator
copy "flamegraph.pl" "%PREFIX%\Library\bin\flamegraph.pl" >nul
(
echo @echo off
echo call perl "%PREFIX%\Library\bin\flamegraph.pl" %%*
) > "%PREFIX%\Library\bin\flamegraph.bat"

:: Install all stackcollapse-* scripts
for %%f in (stackcollapse-*.pl) do (
    copy "%%f" "%PREFIX%\Library\bin\%%f" >nul
    set "basename=%%~nf"
    (
    echo @echo off
    echo call perl "%PREFIX%\Library\bin\%%f" %%*
    ) > "%PREFIX%\Library\bin\!basename!.bat"
)

:: Install difffolded utility
copy "difffolded.pl" "%PREFIX%\Library\bin\difffolded.pl" >nul
(
echo @echo off
echo call perl "%PREFIX%\Library\bin\difffolded.pl" %%*
) > "%PREFIX%\Library\bin\difffolded.bat"
