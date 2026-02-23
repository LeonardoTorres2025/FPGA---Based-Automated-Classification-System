# FPGA---Based-Automated-Classification-System
Developed an automated sorting system to classify M&amp;Ms by color. The project features a color sensor interface and a custom Finite State Machine (FSM) architecture programmed in VHDL/Verilog on an FPGA platform.


This was the model construction for the sorting system.
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/4848a080-ce0b-4bf4-aefc-4105b54b6e0e" />

The following image shows the simplified RTL design of the M&M sorter. The system has two main inputs: the color sensor frequency signal and a reset button.

The outputs include LEDs to indicate the detected color frequency, display connections to show the identified color, and PWM signals used to control the motors. These motors handle both the positioning of the candy for color analysis and its classification into the corresponding containers.

Additionally, a VGA signal is generated to display the detected color on a monitor in real time.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/74bf88d8-95f4-4e14-8b2d-fe5d8fdc6a96" />

The following image shows the extended RTL design, including the modules provided by Xilinx. These modules were integrated into the system to support signal processing, control logic, and hardware interfacing within the FPGA implementation.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/830abe56-ed4d-42c3-99fa-0237bb9a6ed6" />



[Uploading Clasificador de M&M.pdf…]()
