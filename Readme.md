Para compilar el codigo en el MUX ejecutar en la terminal:
```
cd testbench
iverilog -o MUX_tb MUX_tb.v ../MUX.v

vvp MUX_tb

```
https://bleyer.org/icarus/
https://www.msys2.org/
para ver grafica de señales: https://gtkwave.sourceforge.net/