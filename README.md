# 🚦 Traffic Light Controller (Verilog HDL)

This project implements a **Traffic Signal Controller** using **Finite State Machine (FSM)** in Verilog.  
It controls two roads: a **highway (priority road)** and a **country road (secondary road)**. By default, the highway stays green, and the country road only gets a green signal when a vehicle is detected.  

---

## 🔑 Features
- FSM-based design for **realistic traffic light sequencing**  
- **Highway priority**: Highway remains green until a vehicle is detected on the country road  
- **Configurable delays** using macros:  
  - `Y2RDELAY`: Yellow → Red transition delay  
  - `R2GDELAY`: Red → Green transition delay  
- Supports **5 traffic states**:
  - **S0**: Highway Green, Country Red  
  - **S1**: Highway Yellow  
  - **S2**: Highway Red  
  - **S3**: Country Green  
  - **S4**: Country Yellow  

---

## ⚙️ Inputs & Outputs

### Inputs:
- `clock` → System clock  
- `clear` → Reset (forces system to initial state)  
- `X` → Vehicle sensor (1 if vehicle on country road, 0 otherwise)  

### Outputs:
- `hwy[1:0]` → Highway signal (Red, Yellow, Green)  
- `cntry[1:0]` → Country road signal (Red, Yellow, Green)  

---

## 📘 Working Principle

1. Initially, the **highway is green** (state S0), and the **country road is red**.  
2. When a vehicle is detected on the country road (`X=1`), the controller transitions highway → yellow → red.  
3. The country road then turns green, allowing traffic to pass.  
4. After the delay, the country road turns yellow and then red, while the highway turns green again.  
5. This cycle repeats based on sensor input.  

---

## 🔄 State Diagram

```text
   +------+    X=1    +------+
   |  S0  | --------> |  S1  |  (Highway Yellow)
   | Hwy G|           +------+
   | Cty R|               |
   +------+               v
                         +------+
                         |  S2  |  (Highway Red)
                         +------+
                             |
                             v
                         +------+
                         |  S3  |  (Country Green)
                         +------+
                             |
                             v
                         +------+
                         |  S4  |  (Country Yellow)
                         +------+
                             |
                             v
                           back to S0
```

---

## 🛠️ Tools Used
- **Language**: Verilog HDL  
- **Simulation**: Xilinx Vivado / ModelSim  
- **Target**: FPGA-compatible design  

---

## 🚀 Future Enhancements
- Replace `repeat` with **counters for precise delays**  
- Add a **testbench with waveform analysis**  
- Extend design to **multiple intersections**  
- Implement **adaptive traffic control** using sensors  

---

## 📂 Project Structure
```
Traffic_Light_Controller/
│── src/           # Verilog source files
│    └── sig_control.v
│── sim/           # (Optional) Testbenches
│── docs/          # (Optional) FSM diagrams / reports
│── README.md      # Project documentation
│── LICENSE        # License file
```

---

## 📜 License
This project is licensed under the **MIT License**.  
