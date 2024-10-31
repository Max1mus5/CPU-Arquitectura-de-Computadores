
# 💻 Proyecto Arquitectura de Computadores

Para este curos se ha propuesto diseñar y entender como funciona a profundidad el monociclo dentro del marco de arquitectura de RISC-v I32

## Contenido

- [MUX](#mux)
- [ALU](#alu)

## MUX

Un multiplexor o MUX es un circuito digital que tiene múltiples entradas y una sola salida. 
Se utiliza para seleccionar una de las múltiples entradas y enviarla a la salida. 
El número de entradas es una potencia de 2
Este MUX es de 2 a 1, de 32 bits.


## ALU

La unidad aritmético-lógica o ALU (Arithmetic Logic Unit) es un circuito digital que realiza operaciones aritméticas y lógicas en los datos.
La ALU toma dos entradas y una señal de control para realizar una operación específica.
La ALU de este proyecto es de 32 bits.

---

## 🚀 Compilando el Código

Sigue estos sencillos pasos para compilar tu código MUX en Verilog:

 **Super Comando**
```bash
cd .\test\
iverilog -o ../build/{nombre archivo compilado} {archivo testbench}.v ../components/{archivo creador de entidad}
cd ..\view\
vvp ../build/{archivo compilado del testbench}
gtkwave .\{archivo con las señales}
   ```

> *Si no quieres usar el super comando puedes utilizar paso por paso:*

1. **Navega al directorio `testbench`**:
   ```bash
   cd test
   ```

2. **Compila el archivo de testbench**  junto con el módulo:
   ```bash
   iverilog -o ../build/{nombre archivo compilado} {archivo testbench}.v ../components/{archivo modulo}
   ```

3. **Ejecuta la simulación**:
   ```bash
   cd ..\view\
   vvp ../build/{archivo compilado del testbench}
   ```

4. **Ver las señales en GTKWave**:
   ```bash
   gtkwave .\{archivo con las señales}
   ```
   o si bien quieres ver las señales de un archivo en especifico
   ```bash
   gtkwave (*ruta del archivo*)
   ```

✨ **¡Y listo!** Si todo salió bien, tu simulación se ejecutará, generando un archivo `.vcd` con las señales de entrada y salida.



---

## 📊 Visualiza las Señales en GTKWave

Para hacer tu análisis más visual y entender mejor el comportamiento de tu diseño, sigue estos pasos para ver las señales en **GTKWave**:

1. **Abre GTKWave**:
   ```bash
   gtkwave (*ruta del archivo*)
   ```

2. **Explora las señales**:
   - Selecciona las señales que quieres visualizar.
   - Disfruta viendo cómo cambian las señales de entrada y salida a lo largo del tiempo. ¡Es como darle vida a tu código! 🎉

---

## 🛠️ Recursos Adicionales

Para configurar tu entorno de desarrollo y trabajar con Verilog, te recomiendo los siguientes recursos:

- **Icarus Verilog**: [Guía y descarga](https://bleyer.org/icarus/) 📘
- **MSYS2**: [Instalación y configuración](https://www.msys2.org/) 💻
- **GTKWave**: [Página oficial](https://gtkwave.sourceforge.net/) 🌐
- **Extension Recomendadas:**
<img src="./assets/Extensions.png">
---


**JERONIMO RIVEROS**
