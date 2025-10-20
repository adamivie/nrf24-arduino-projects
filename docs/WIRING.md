# Wiring Guide

## NRF24L01 to Arduino Uno Connections

### Standard Configuration

| NRF24L01 Pin | Arduino Uno Pin | Wire Color* | Description |
|--------------|-----------------|-------------|-------------|
| VCC          | 3.3V            | Red         | Power supply (3.3V ONLY!) |
| GND          | GND             | Black       | Ground |
| CE           | 7               | Yellow      | Chip Enable |
| CSN          | 8               | Green       | SPI Chip Select |
| SCK          | 13              | Blue        | SPI Serial Clock |
| MOSI         | 11              | Orange      | SPI Master Out Slave In |
| MISO         | 12              | Purple      | SPI Master In Slave Out |
| IRQ          | Not Connected   | -           | Interrupt (not used) |

*Wire colors are suggestions for easier identification

## Visual Wiring Diagram

```
    Arduino Uno                    NRF24L01
   ┌─────────────┐               ┌─────────────┐
   │         3.3V├───────────────┤VCC      GND├─┐
   │         GND├─┐               └─────────────┘ │
   │          D7├─┼───────────────┤CE             │
   │          D8├─┼───────────────┤CSN            │
   │         D11├─┼───────────────┤MOSI           │
   │         D12├─┼───────────────┤MISO           │
   │         D13├─┼───────────────┤SCK            │
   │            │ └───────────────┤GND            │
   └─────────────┘                 └─────────────┘
```

## 🚨 Critical Notes

### Power Supply
- **MUST use 3.3V** - NRF24L01 will be damaged by 5V!
- Arduino Uno 3.3V pin provides ~50mA maximum
- For long-range projects, consider external 3.3V regulator
- Add 10µF capacitor between VCC and GND for stable power

### Pin Selection
- **CE (Chip Enable):** Can be any digital pin (we use pin 7)
- **CSN (Chip Select):** Can be any digital pin (we use pin 8)  
- **SPI pins (SCK/MOSI/MISO):** Must use hardware SPI pins on Arduino Uno
- Avoid using pin 10 for CSN as it's the default SPI SS pin

### Alternative Pin Configuration

If you experience issues with the standard configuration, try:

| Component | Standard Pin | Alternative Pin | Notes |
|-----------|-------------|-----------------|-------|
| CE        | 7           | 9              | Any digital pin works |
| CSN       | 8           | 10             | Avoid pin 10 if possible |

## Breadboard Layout

```
NRF24L01 Module Pinout (viewed from component side):
┌─────────────────┐
│  ●●●●  ●●●●     │
│  1234  5678     │
└─────────────────┘

Pin Numbers:
1. GND     5. SCK
2. VCC     6. MOSI  
3. CE      7. MISO
4. CSN     8. IRQ (not used)
```

## Power Supply Options

### Option 1: Arduino 3.3V Pin (Basic)
- Connect NRF24L01 VCC directly to Arduino 3.3V pin
- Add 10µF capacitor between VCC and GND
- Suitable for close-range communication

### Option 2: External 3.3V Regulator (Recommended)
- Use AMS1117-3.3 or similar regulator
- Input: Arduino 5V pin  
- Output: Stable 3.3V for NRF24L01
- Better for long-range and reliable communication

### Option 3: Dedicated 3.3V Supply
- Use separate 3.3V power supply
- Connect grounds together
- Best option for maximum performance

## Common Wiring Mistakes

❌ **Wrong:** VCC to 5V (will damage module!)  
✅ **Correct:** VCC to 3.3V

❌ **Wrong:** Loose breadboard connections  
✅ **Correct:** Secure, clean connections

❌ **Wrong:** Long jumper wires  
✅ **Correct:** Short wires to minimize interference

❌ **Wrong:** No power supply filtering  
✅ **Correct:** 10µF capacitor near NRF24L01

## Testing Your Wiring

After wiring, run the diagnostic sketch to verify connections:

```cpp
// Upload nrf24_diagnostic.ino to test your wiring
// It will report connection status and identify issues
```

Expected diagnostic output:
```
✅ Radio Initialization: SUCCESS
✅ Chip Connection: CONNECTED  
✅ Basic Configuration: SUCCESS
✅ Configuration Readback: SUCCESS
```

## Troubleshooting Wiring Issues

| Symptom | Likely Cause | Solution |
|---------|-------------|----------|
| "Radio initialization failed" | Power or wiring issue | Check 3.3V power, verify all connections |
| "Chip not connected" | SPI wiring problem | Verify SCK/MOSI/MISO connections |
| Intermittent operation | Poor connections | Secure all wires, add power capacitor |
| No communication | Wrong pins | Double-check CE/CSN pin assignments |

## Advanced Tips

### Range Optimization
- Keep antenna (PCB trace) clear of obstructions
- Orient antennas parallel to each other
- Minimize interference from WiFi, Bluetooth, etc.
- Use shorter wires for SPI connections

### Multiple Modules
- Each module needs unique CSN pin
- Share CE, SCK, MOSI, MISO between modules
- Manage CSN pins in software for module selection

### PCB Design
- Keep NRF24L01 away from switching circuits
- Use ground plane for noise reduction
- Add ferrite beads on power lines if needed
- Consider antenna placement for optimal radiation pattern