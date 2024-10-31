module BranchUnit(
    input logic [31:0] regValue1,            // Valor del registro 1 (rs1)
    input logic [31:0] regValue2,            // Valor del registro 2 (rs2)
    input logic [4:0] branchOperation,       // Operación de salto (BrOp)
    
    output logic nextPCSource                // Señal de destino para el siguiente PC
);

    // Lógica combinacional para determinar el siguiente destino del PC
    always @(*) begin
        // Si se activa la señal de salto incondicional
        if (branchOperation[4] == 1'b1) begin
            nextPCSource = 1'b1;               // Salto incondicional
        end else begin
            // Si no hay operación de salto
            if (branchOperation[4:3] == 2'b0) begin
                nextPCSource = 1'b0;           // No se realiza salto
            end else begin
                // Determina el tipo de comparación para el salto
                case (branchOperation)
                    5'b01000: nextPCSource = (regValue1 == regValue2);  // Igualdad
                    5'b01001: nextPCSource = (regValue1 != regValue2);  // Desigualdad
                    5'b01100: nextPCSource = ($signed(regValue1) < $signed(regValue2)); // Menor (signed)
                    5'b01101: nextPCSource = ($signed(regValue1) >= $signed(regValue2)); // Mayor o igual (signed)
                    5'b01110: nextPCSource = (regValue1 < regValue2);  // Menor (unsigned)
                    5'b01111: nextPCSource = (regValue1 >= regValue2); // Mayor o igual (unsigned)
                    default: nextPCSource = 0;  // Valor por defecto (no salto)
                endcase
            end
        end
    end

endmodule
