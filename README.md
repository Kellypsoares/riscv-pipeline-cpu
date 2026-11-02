# CPU RISC-V RV32I: Pipeline de 5 Estágios

Projeto de implementação de uma CPU RISC-V de 32 bits utilizando o simulador Digital e módulos desenvolvidos em Verilog.

## 1. Requisitos

Para executar o projeto, são necessários:

- Digital (simulador de circuitos lógicos).
- Icarus Verilog (IVerilog).
- Um editor de código para configurar os caminhos dos arquivos.

## 2. Abrindo o projeto

1. Baixe e extraia a pasta completa do projeto.
2. Abra o arquivo `CPU_RISCV.dig` no Digital.
3. Verifique se os componentes Verilog externos apontam para os arquivos `.v` correspondentes.
4. Confira se a aplicação dos componentes externos está configurada como `IVerilog`.
5. Nas configurações do Digital, verifique se o executável do IVerilog está configurado corretamente.

## 3. Configuração da memória de instruções

O arquivo `InstructionMemory_32.v` utiliza `$readmemh` para carregar as instruções armazenadas em `program.hex`.

**Importante:** antes de executar o projeto em outro computador, é necessário atualizar o caminho do arquivo `program.hex`.

Abra `InstructionMemory_32.v` e localize:

```verilog
$readmemh("/Users/kellysoares/Documents/Faculdade/arqComp/RICV_entrega/program.hex", memory);
```

Substitua pelo caminho absoluto correspondente ao local onde o projeto foi salvo.

Exemplo para macOS:

```verilog
$readmemh("/Users/seu_usuario/Documents/RICV_entrega/program.hex", memory);
```

Exemplo para Windows:

```verilog
$readmemh("C:/Users/seu_usuario/Documents/RICV_entrega/program.hex", memory);
```

Salve o arquivo e reinicie a simulação no Digital.

## 4. Programa de teste

O arquivo `program.hex` contém três instruções RISC-V:

| Endereço | Código hexadecimal | Instrução |
|---|---|---|
| 0 | `00A00093` | `addi x1, x0, 10` |
| 4 | `01400113` | `addi x2, x0, 20` |
| 8 | `002081B3` | `add x3, x1, x2` |

## 5. Testando a busca de instruções

1. Abra `CPU_RISCV.dig` no Digital.
2. Inicie a simulação.
3. Ative o sinal `reset` e depois desative-o.
4. Configure `PCWrite = 1`.
5. Observe os valores de `PC`, `PCPlus4` e `Instruction`.
6. Avance o Clock para buscar as próximas instruções.

Valores esperados:

| PC | PCPlus4 | Instruction |
|---|---|---|
| 0 | 4 | `00A00093` |
| 4 | 8 | `01400113` |
| 8 | 12 | `002081B3` |

Cada borda de subida do Clock atualiza o Program Counter.

## 6. Estado atual da implementação

Os seguintes componentes foram implementados e testados individualmente ou em integração inicial:

- ALU de 32 bits.
- Banco de 32 registradores.
- Program Counter de 32 bits.
- Somador PC + 4.
- Memória de instruções, com leitura inicial do arquivo hexadecimal validada.

**Observação:** a implementação completa do pipeline de cinco estágios ainda está em desenvolvimento. Os testes atuais verificam os componentes e a busca de instruções, não a execução completa do programa.


## Configuração dos caminhos dos módulos Verilog no Digital

O circuito utiliza módulos Verilog externos, referenciados pelo simulador Digital. Como os caminhos desses arquivos podem variar entre computadores, é necessário verificar as referências antes de iniciar a simulação.

### Procedimento

1. Baixe e extraia a pasta completa do projeto.
2. Abra o arquivo `CPU_RISCV.dig` no Digital.
3. Para cada componente Verilog externo, abra suas propriedades.
4. No campo **Program code**, selecione o arquivo `.v` correspondente, localizado na pasta do projeto.
5. Confira se **Application** está configurado como `IVerilog`.
6. Repita o procedimento para os demais módulos externos.
7. Nas configurações do Digital, verifique se o executável do Icarus Verilog está configurado corretamente.

### Arquivos Verilog

| Componente no Digital | Arquivo correspondente |
|---|---|
| ALU_32 | `ALU_32.v` |
| RegisterFile_32 | `RegisterFile_32.v` |
| ProgramCounter_32 | `ProgramCounter_32.v` |
| PC_Adder_32 | `PC_Adder_32.v` |
| InstructionMemory_32 | `InstructionMemory_32.v` |
| IF_ID_Register | `IF_ID_Register.v` |

### Configuração adicional da memória

Além dos caminhos dos componentes, é necessário atualizar o caminho absoluto de `program.hex` dentro de `InstructionMemory_32.v`, conforme explicado na seção **Configuração da memória de instruções**.

Após salvar as alterações, reinicie a simulação.

**Importante:** não é necessário modificar a lógica dos módulos Verilog. Apenas as referências aos arquivos devem ser ajustadas para o ambiente em que o projeto será executado.