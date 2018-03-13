@echo off

echo *** Set ExecutionPolicy to RemoteSigned ***
@powershell Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
echo.

echo *** Setup Vagrant plugins ***
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-address

echo *** Vagrant up ***
vagrant up --provider hyperv

if %errorlevel% == 0 (
	call ::port_forwarding_setup
) else (
	exit /b 1
)

goto :end

:port_forwarding_setup
	set command="vagrant address"
	for /f %%i in (' %command% ') do set VIRTUAL_MACHINE_IP=%%i

	@powershell .\hypervportforward.ps1 -GuestIPAddress %VIRTUAL_MACHINE_IP%
goto :eof

:end
vagrant reload