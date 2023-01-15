@ECHO ON

echo "osdk_execute.bat"

::
:: Initial check.
:: Verify if the SDK is correctly configurated,
::
IF "%OSDK%"=="" GOTO ErCfg

::
:: Set the build paremeters
::

cd
CALL osdk_config.bat

echo  %OSDKNAME% +++++++++++++++++++
::
:: Run Euphoric using the common batch
::
:: CALL %OSDK%\Euphoric\osdk_euphoric.bat

D:
CD %OSDK%
CD ..\oricutron
oricutron.exe -ma -t%OSDKNAME%.tap -ssymbols 
GOTO End


::
:: Outputs an error message about configuration
::
:ErCfg
ECHO == ERROR ==
ECHO The Oric SDK was not configured properly
ECHO You should have a OSDK environment variable setted to the location of the SDK
ECHO ===========
IF "%OSDKBRIEF%"=="" PAUSE
GOTO End

:End
:::pause