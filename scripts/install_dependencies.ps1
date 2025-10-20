# NRF24L01 Arduino Projects - Dependency Installation Script
# This script helps install the required RF24 library for Arduino IDE

param(
    [Parameter(HelpMessage="Path to Arduino CLI executable (optional)")]
    [string]$ArduinoCliPath = "",
    
    [Parameter(HelpMessage="Install using Arduino CLI instead of manual instructions")]
    [switch]$UseArduinoCli
)

Write-Host "NRF24L01 Arduino Projects - Dependency Installation" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
Write-Host ""

# Function to check if Arduino CLI is available
function Test-ArduinoCli {
    param([string]$CliPath)
    
    if ($CliPath -ne "") {
        return Test-Path $CliPath
    }
    
    try {
        $null = Get-Command "arduino-cli" -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Function to install via Arduino CLI
function Install-ViaArduinoCli {
    param([string]$CliPath = "arduino-cli")
    
    Write-Host "Installing RF24 library using Arduino CLI..." -ForegroundColor Yellow
    
    try {
        # Update library index
        Write-Host "Updating library index..." -ForegroundColor Cyan
        if ($CliPath -ne "arduino-cli") {
            & $CliPath lib update-index
        } else {
            arduino-cli lib update-index
        }
        
        # Install RF24 library
        Write-Host "Installing RF24 library by TMRh20..." -ForegroundColor Cyan
        if ($CliPath -ne "arduino-cli") {
            & $CliPath lib install "RF24"
        } else {
            arduino-cli lib install "RF24"
        }
        
        Write-Host "✓ RF24 library installed successfully!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "✗ Error installing RF24 library via Arduino CLI: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Function to provide manual installation instructions
function Show-ManualInstructions {
    Write-Host "Manual Installation Instructions:" -ForegroundColor Yellow
    Write-Host "=================================" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Since Arduino CLI is not available, please follow these steps:" -ForegroundColor White
    Write-Host ""
    Write-Host "1. Open Arduino IDE" -ForegroundColor Cyan
    Write-Host "2. Go to Tools > Manage Libraries..." -ForegroundColor Cyan
    Write-Host "3. In the Library Manager search box, type: RF24" -ForegroundColor Cyan
    Write-Host "4. Look for 'RF24 by TMRh20' in the results" -ForegroundColor Cyan
    Write-Host "5. Click 'Install' button" -ForegroundColor Cyan
    Write-Host "6. Wait for installation to complete" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Alternative method using ZIP file:" -ForegroundColor Yellow
    Write-Host "1. Download RF24 library from: https://github.com/nRF24/RF24" -ForegroundColor Cyan
    Write-Host "2. In Arduino IDE, go to Sketch > Include Library > Add .ZIP Library..." -ForegroundColor Cyan
    Write-Host "3. Select the downloaded ZIP file" -ForegroundColor Cyan
    Write-Host ""
}

# Function to verify installation
function Test-LibraryInstallation {
    Write-Host "Verifying installation..." -ForegroundColor Yellow
    
    # Common Arduino library paths
    $libraryPaths = @(
        "$env:USERPROFILE\Documents\Arduino\libraries\RF24",
        "$env:USERPROFILE\AppData\Local\Arduino15\libraries\RF24",
        "$env:PROGRAMFILES\Arduino\libraries\RF24",
        "${env:PROGRAMFILES(X86)}\Arduino\libraries\RF24"
    )
    
    foreach ($path in $libraryPaths) {
        if (Test-Path $path) {
            Write-Host "✓ RF24 library found at: $path" -ForegroundColor Green
            return $true
        }
    }
    
    Write-Host "⚠ RF24 library not found in common locations." -ForegroundColor Yellow
    Write-Host "  This doesn't necessarily mean it's not installed." -ForegroundColor Yellow
    Write-Host "  Try compiling one of the sketches to verify." -ForegroundColor Yellow
    return $false
}

# Function to show next steps
function Show-NextSteps {
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "===========" -ForegroundColor Yellow
    Write-Host "1. Wire your NRF24L01 modules according to docs/WIRING.md" -ForegroundColor Cyan
    Write-Host "2. Choose your project:" -ForegroundColor Cyan
    Write-Host "   • Wireless Chat: Upload terminal_a and terminal_b sketches" -ForegroundColor White
    Write-Host "   • Range Testing: Upload range transmitter and receiver sketches" -ForegroundColor White
    Write-Host "   • Diagnostics: Upload diagnostic sketch to test hardware" -ForegroundColor White
    Write-Host "3. Open Serial Monitor (9600 baud) to see output" -ForegroundColor Cyan
    Write-Host "4. Check docs/TROUBLESHOOTING.md if you have issues" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Project documentation: https://github.com/adamivie/nrf24-arduino-projects" -ForegroundColor Green
    Write-Host ""
}

# Main execution
Write-Host "Required Dependencies:" -ForegroundColor White
Write-Host "- RF24 library by TMRh20" -ForegroundColor Cyan
Write-Host "- Arduino IDE (or Arduino CLI)" -ForegroundColor Cyan
Write-Host ""

# Check if we should use Arduino CLI
if ($UseArduinoCli -or ($ArduinoCliPath -ne "")) {
    $cliPath = if ($ArduinoCliPath -ne "") { $ArduinoCliPath } else { "arduino-cli" }
    
    if (Test-ArduinoCli -CliPath $cliPath) {
        Write-Host "Arduino CLI detected. Installing dependencies..." -ForegroundColor Green
        $success = Install-ViaArduinoCli -CliPath $cliPath
        
        if ($success) {
            Test-LibraryInstallation
            Show-NextSteps
        } else {
            Write-Host ""
            Write-Host "Arduino CLI installation failed. Showing manual instructions..." -ForegroundColor Yellow
            Show-ManualInstructions
        }
    } else {
        Write-Host "Arduino CLI not found at specified path: $cliPath" -ForegroundColor Red
        Write-Host "Showing manual installation instructions..." -ForegroundColor Yellow
        Write-Host ""
        Show-ManualInstructions
    }
} else {
    # Check if Arduino CLI is available anyway
    if (Test-ArduinoCli) {
        Write-Host "Arduino CLI is available. You can use it by running:" -ForegroundColor Green
        Write-Host "  .\scripts\install_dependencies.ps1 -UseArduinoCli" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Or follow the manual instructions below:" -ForegroundColor Yellow
        Write-Host ""
    }
    
    Show-ManualInstructions
    
    # Check if library might already be installed
    Write-Host ""
    Test-LibraryInstallation
}

Show-NextSteps

Write-Host "Installation script completed!" -ForegroundColor Green