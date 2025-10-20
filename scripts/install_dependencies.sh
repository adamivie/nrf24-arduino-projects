#!/bin/bash

# NRF24L01 Arduino Projects - Dependency Installation Script (Linux/macOS)
# This script helps install the required RF24 library for Arduino IDE

ARDUINO_CLI_PATH=""
USE_ARDUINO_CLI=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${1}${2}${NC}\n"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --arduino-cli-path PATH    Specify path to arduino-cli executable"
    echo "  --use-arduino-cli          Use Arduino CLI for installation"
    echo "  -h, --help                Show this help message"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --arduino-cli-path)
            ARDUINO_CLI_PATH="$2"
            shift 2
            ;;
        --use-arduino-cli)
            USE_ARDUINO_CLI=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

print_color $GREEN "NRF24L01 Arduino Projects - Dependency Installation"
print_color $GREEN "==================================================="
echo ""

# Function to check if Arduino CLI is available
check_arduino_cli() {
    if [[ -n "$ARDUINO_CLI_PATH" ]]; then
        if [[ -x "$ARDUINO_CLI_PATH" ]]; then
            return 0
        else
            return 1
        fi
    fi
    
    if command -v arduino-cli &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to install via Arduino CLI
install_via_arduino_cli() {
    local cli_path="${ARDUINO_CLI_PATH:-arduino-cli}"
    
    print_color $YELLOW "Installing RF24 library using Arduino CLI..."
    
    # Update library index
    print_color $CYAN "Updating library index..."
    if ! $cli_path lib update-index; then
        print_color $RED "✗ Error updating library index"
        return 1
    fi
    
    # Install RF24 library
    print_color $CYAN "Installing RF24 library by TMRh20..."
    if ! $cli_path lib install "RF24"; then
        print_color $RED "✗ Error installing RF24 library"
        return 1
    fi
    
    print_color $GREEN "✓ RF24 library installed successfully!"
    return 0
}

# Function to provide manual installation instructions
show_manual_instructions() {
    print_color $YELLOW "Manual Installation Instructions:"
    print_color $YELLOW "================================="
    echo ""
    print_color $WHITE "Since Arduino CLI is not available, please follow these steps:"
    echo ""
    print_color $CYAN "1. Open Arduino IDE"
    print_color $CYAN "2. Go to Tools > Manage Libraries..."
    print_color $CYAN "3. In the Library Manager search box, type: RF24"
    print_color $CYAN "4. Look for 'RF24 by TMRh20' in the results"
    print_color $CYAN "5. Click 'Install' button"
    print_color $CYAN "6. Wait for installation to complete"
    echo ""
    print_color $YELLOW "Alternative method using ZIP file:"
    print_color $CYAN "1. Download RF24 library from: https://github.com/nRF24/RF24"
    print_color $CYAN "2. In Arduino IDE, go to Sketch > Include Library > Add .ZIP Library..."
    print_color $CYAN "3. Select the downloaded ZIP file"
    echo ""
    
    print_color $YELLOW "Linux/macOS CLI installation (if you have package manager):"
    print_color $CYAN "Ubuntu/Debian: sudo apt install arduino-cli"
    print_color $CYAN "macOS: brew install arduino-cli"
    print_color $CYAN "Arch Linux: sudo pacman -S arduino-cli"
    echo ""
}

# Function to verify installation
verify_library_installation() {
    print_color $YELLOW "Verifying installation..."
    
    # Common Arduino library paths on Linux/macOS
    local library_paths=(
        "$HOME/Arduino/libraries/RF24"
        "$HOME/.arduino15/libraries/RF24"
        "/usr/share/arduino/libraries/RF24"
        "/opt/arduino/libraries/RF24"
    )
    
    for path in "${library_paths[@]}"; do
        if [[ -d "$path" ]]; then
            print_color $GREEN "✓ RF24 library found at: $path"
            return 0
        fi
    done
    
    print_color $YELLOW "⚠ RF24 library not found in common locations."
    print_color $YELLOW "  This doesn't necessarily mean it's not installed."
    print_color $YELLOW "  Try compiling one of the sketches to verify."
    return 1
}

# Function to show next steps
show_next_steps() {
    echo ""
    print_color $YELLOW "Next Steps:"
    print_color $YELLOW "==========="
    print_color $CYAN "1. Wire your NRF24L01 modules according to docs/WIRING.md"
    print_color $CYAN "2. Choose your project:"
    print_color $WHITE "   • Wireless Chat: Upload terminal_a and terminal_b sketches"
    print_color $WHITE "   • Range Testing: Upload range transmitter and receiver sketches"  
    print_color $WHITE "   • Diagnostics: Upload diagnostic sketch to test hardware"
    print_color $CYAN "3. Open Serial Monitor (9600 baud) to see output"
    print_color $CYAN "4. Check docs/TROUBLESHOOTING.md if you have issues"
    echo ""
    print_color $GREEN "Project documentation: https://github.com/yourusername/nrf24-arduino-projects"
    echo ""
}

# Main execution
print_color $WHITE "Required Dependencies:"
print_color $CYAN "- RF24 library by TMRh20"
print_color $CYAN "- Arduino IDE (or Arduino CLI)"
echo ""

# Check if we should use Arduino CLI
if [[ "$USE_ARDUINO_CLI" == true ]] || [[ -n "$ARDUINO_CLI_PATH" ]]; then
    if check_arduino_cli; then
        print_color $GREEN "Arduino CLI detected. Installing dependencies..."
        if install_via_arduino_cli; then
            verify_library_installation
            show_next_steps
        else
            echo ""
            print_color $YELLOW "Arduino CLI installation failed. Showing manual instructions..."
            show_manual_instructions
        fi
    else
        print_color $RED "Arduino CLI not found at specified path: ${ARDUINO_CLI_PATH:-arduino-cli}"
        print_color $YELLOW "Showing manual installation instructions..."
        echo ""
        show_manual_instructions
    fi
else
    # Check if Arduino CLI is available anyway
    if check_arduino_cli; then
        print_color $GREEN "Arduino CLI is available. You can use it by running:"
        print_color $CYAN "  ./scripts/install_dependencies.sh --use-arduino-cli"
        echo ""
        print_color $YELLOW "Or follow the manual instructions below:"
        echo ""
    fi
    
    show_manual_instructions
    
    # Check if library might already be installed
    echo ""
    verify_library_installation
fi

show_next_steps

print_color $GREEN "Installation script completed!"