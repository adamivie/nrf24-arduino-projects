# NRF24L01 Arduino Communication Projects

[![Arduino](https://img.shields.io/badge/Arduino-Compatible-blue.svg)](https://www.arduino.cc/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![NRF24L01](https://img.shields.io/badge/Module-NRF24L01-red.svg)](https://www.sparkfun.com/datasheets/Components/SMD/nRF24L01Pluss_Preliminary_Product_Specification_v1_0.pdf)

A collection of Arduino projects for NRF24L01 wireless communication modules, featuring range testing, wireless chat, and diagnostic tools.

## 🌟 Features

- **📡 Wireless Chat System** - Real-time bidirectional text communication
- **📊 Range Testing** - Professional packet loss analysis with LED indicators  
- **🔧 Diagnostic Tools** - Hardware testing and troubleshooting utilities
- **📱 User-Friendly** - Clean Serial Monitor interface with visual feedback
- **🎯 Reliable** - Tested pin configurations and error handling

## 📁 Project Structure

```
nrf24-arduino-projects/
├── nrf24_chat_terminal_a/          # Wireless chat - Terminal A
├── nrf24_chat_terminal_b/          # Wireless chat - Terminal B
├── nrf24_range_transmitter/        # Range test transmitter
├── nrf24_range_receiver/           # Range test receiver
├── nrf24_diagnostic/               # Hardware diagnostic tool
├── scripts/
│   ├── install_dependencies.ps1    # PowerShell installer
│   ├── install_dependencies.sh     # Linux/macOS installer
│   └── install_dependencies.bat    # Windows batch installer
├── docs/
│   ├── WIRING.md                  # Detailed wiring guide
│   ├── TROUBLESHOOTING.md         # Common issues and solutions
│   └── API.md                     # Code documentation
├── examples/                       # Additional example code
├── LICENSE                        # MIT License
└── README.md                      # This file
```

## 🚀 Quick Start

### Prerequisites

- 2x Arduino Uno (or compatible)
- 2x NRF24L01 wireless modules  
- Jumper wires
- Arduino IDE
- RF24 library by TMRh20

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/adamivie/nrf24-arduino-projects.git
   cd nrf24-arduino-projects
   ```

2. **Install dependencies:**
   
   **Windows (PowerShell):**
   ```powershell
   .\scripts\install_dependencies.ps1
   ```
   
   **Linux/macOS:**
   ```bash
   ./scripts/install_dependencies.sh
   ```

3. **Wire your NRF24L01 modules** (see [Wiring Guide](docs/WIRING.md))

## 🔌 Basic Wiring

| NRF24L01 Pin | Arduino Uno Pin | Description |
|--------------|-----------------|-------------|
| VCC          | 3.3V            | Power (3.3V only!) |
| GND          | GND             | Ground |
| CE           | 7               | Chip Enable |
| CSN          | 8               | SPI Chip Select |
| SCK          | 13              | SPI Clock |
| MOSI         | 11              | SPI Data Out |
| MISO         | 12              | SPI Data In |

⚠️ **Important:** NRF24L01 requires 3.3V power, NOT 5V!

## 💬 Wireless Chat Application

The wireless chat system allows real-time text communication between two Arduino boards through their Serial Monitors.

### Setup

1. Upload `nrf24_chat_terminal_a.ino` to first Arduino
2. Upload `nrf24_chat_terminal_b.ino` to second Arduino  
3. Open Serial Monitor for both (9600 baud)
4. Set line ending to "Newline" or "Both NL & CR"

### Usage

```
NRF24L01 Wireless Chat - Terminal A
====================================
Type your message and press Enter to send
Messages from Terminal B will appear below
------------------------------------

Terminal A> Hello from Arduino A! [SENT]
Terminal B> Hi there! This is Arduino B.
Terminal A> The wireless chat works great! [SENT]
Terminal B> I agree! Crystal clear communication.
Terminal A> 
```

### Features

- ✅ **Bidirectional communication**
- ✅ **Real-time message display**  
- ✅ **Visual feedback** (SENT/FAILED status)
- ✅ **Character echo** as you type
- ✅ **Clean interface** with proper formatting

## 📊 Range Testing System

Professional range testing with packet statistics and LED status indicators.

### Features

- Continuous packet transmission with counters
- Real-time packet loss calculation
- Signal strength estimation
- LED status indicators for transmission/reception
- Detailed statistics output

### Usage

1. Upload transmitter code to first Arduino
2. Upload receiver code to second Arduino
3. Start close together to verify communication
4. Gradually increase distance while monitoring packet loss
5. Record maximum reliable range

## 🔧 Diagnostic Tools

Hardware testing utilities to troubleshoot NRF24L01 connection issues.

### NRF24L01 Diagnostic

Comprehensive hardware test that checks:
- SPI communication
- Register read/write operations  
- Multiple pin configurations
- Power supply verification

### Basic Connection Tester

Low-level SPI testing without RF24 library dependencies.

## 🛠️ Troubleshooting

### Common Issues

| Problem | Solution |
|---------|----------|
| "Radio initialization failed" | Check wiring, verify 3.3V power |
| No communication | Try different CSN pin (7 instead of 8) |
| Intermittent connection | Add 10µF capacitor between VCC/GND |
| Range too short | Check antenna orientation, reduce interference |

See [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) for detailed solutions.

## 📚 Documentation

- **[Wiring Guide](docs/WIRING.md)** - Detailed connection diagrams
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and fixes
- **[API Reference](docs/API.md)** - Code documentation
- **[Examples](examples/)** - Additional sample code

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- TMRh20 for the excellent [RF24 library](https://github.com/tmrh20/RF24)
- Arduino community for inspiration and support
- NRF24L01 datasheet authors for technical specifications

## 📞 Support

- 🐛 **Issues:** [GitHub Issues](https://github.com/adamivie/nrf24-arduino-projects/issues)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/adamivie/nrf24-arduino-projects/discussions)
- 📧 **Email:** adamivie@example.com

## 🌟 Star History

If you find this project helpful, please consider giving it a star! ⭐

---

**Made with ❤️ for the Arduino community**