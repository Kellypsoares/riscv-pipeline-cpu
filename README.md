# CPU RISC-V RV32I: Pipeline de 5 Estágios

Implementação de uma CPU RISC-V de 32 bits com pipeline de cinco estágios, desenvolvida no simulador **Digital**, utilizando módulos em **Verilog** e simulação com **Icarus Verilog (IVerilog)**.

O processador implementa um subconjunto de 21 instruções da arquitetura RV32I, incluindo operações aritméticas, lógicas, deslocamentos, acesso à memória, desvios condicionais e saltos.

O projeto também inclui mecanismos de **forwarding**, detecção de hazards e controle de fluxo para permitir a execução de instruções com dependências de dados.

## 1. Requisitos

Para executar o projeto, são necessários:

- Digital — simulador de circuitos lógicos.
- Icarus Verilog (IVerilog) — compilação e simulação dos módulos Verilog.
- Editor de código, como VS Code — configuração dos caminhos e edição dos programas de teste.

## 2. Arquitetura do processador

O processador utiliza um pipeline de cinco estágios:

| Estágio | Nome | Função |
|---|---|---|
| IF | Instruction Fetch | Busca da instrução na memória |
| ID | Instruction Decode | Decodificação, leitura dos registradores e geração de sinais de controle |
| EX | Execute | Operações da ALU, cálculo de endereços e processamento de desvios |
| MEM | Memory Access | Leitura e escrita na memória de dados |
| WB | Write Back | Escrita dos resultados no banco de registradores |

Os registradores de pipeline `IF/ID`, `ID/EX`, `EX/MEM` e `MEM/WB` armazenam as informações necessárias entre os estágios.

### Tratamento de hazards

O processador implementa mecanismos para lidar com dependências de dados e alterações no fluxo de execução:

- **EX/MEM → EX forwarding:** encaminhamento de resultados de instruções anteriores diretamente para a ALU.
- **MEM/WB → EX forwarding:** encaminhamento de valores disponíveis no estágio de write-back.
- **WB → ID forwarding:** encaminhamento do dado de escrita diretamente para a leitura do banco de registradores quando os endereços coincidem.
- **Load-use hazard detection:** detecção de dependências envolvendo instruções `LW`, com controle de stall.
- **Controle de desvios e saltos:** seleção do próximo PC para instruções `BEQ`, `BNE`, `JAL` e `JALR`.

Esses mecanismos permitem executar os programas de teste com dependências de dados sem inserir manualmente instruções NOP.

## 3. Instruções implementadas

O processador suporta 21 instruções do conjunto RV32I:

| Categoria | Instruções |
|---|---|
| Aritméticas | `ADD`, `ADDI`, `SUB` |
| Lógicas | `AND`, `ANDI`, `OR`, `ORI`, `XOR`, `XORI` |
| Deslocamentos | `SLL`, `SLLI`, `SRL`, `SRLI` |
| Memória | `LW`, `SW` |
| Desvios condicionais | `BEQ`, `BNE` |
| Saltos | `JAL`, `JALR` |
| Imediatos superiores | `LUI`, `AUIPC` |

**Observação:** o projeto implementa um subconjunto de RV32I, não o conjunto completo de instruções da arquitetura.

## 4. Abrindo o projeto

1. Baixe ou clone o repositório.
2. Abra o arquivo `CPU_RISCV.dig` no Digital.
3. Verifique se os componentes externos estão associados aos arquivos `.v` correspondentes.
4. Confira se a opção **Application** está configurada como `IVerilog`.
5. Verifique se o executável do Icarus Verilog está configurado corretamente no Digital.
6. Atualize o caminho de `program.hex` na memória de instruções, conforme a seção seguinte.

## 5. Configuração da memória de instruções

O módulo `InstructionMemory_32.v` utiliza `$readmemh` para carregar as instruções do arquivo `program.hex`.

Antes de executar o projeto em outro computador, é necessário verificar o caminho configurado.

No arquivo `InstructionMemory_32.v`, localize:

```verilog
$readmemh("/Users/kellysoares/Documents/Faculdade/arqComp/RICV_entrega/program.hex", memory);
```

Substitua pelo caminho absoluto correspondente à pasta onde o projeto foi salvo.

**Exemplo para macOS:**

```verilog
$readmemh("/Users/seu_usuario/Documents/RICV_entrega/program.hex", memory);
```

**Exemplo para Windows:**

```verilog
$readmemh("C:/Users/seu_usuario/Documents/RICV_entrega/program.hex", memory);
```

Após a alteração, salve o arquivo e reinicie a simulação no Digital.

## 6. Configuração dos módulos Verilog no Digital

O circuito utiliza componentes Verilog externos. As referências aos arquivos podem precisar de atualização quando o projeto é executado em outro computador.

### Procedimento

1. Abra `CPU_RISCV.dig`.
2. Selecione um componente Verilog externo.
3. Abra suas propriedades.
4. No campo **Program code**, selecione o arquivo `.v` correspondente.
5. Confirme que **Application** está configurado como `IVerilog`.
6. Repita para os demais componentes externos.

### Principais módulos

| Módulo | Responsabilidade |
|---|---|
| `ProgramCounter_32` | Armazenamento do PC |
| `PC_Adder_32` | Cálculo de PC + 4 |
| `InstructionMemory_32` | Busca de instruções |
| `IF_ID_Register` | Registrador de pipeline IF/ID |
| `InstructionDecoder_32` | Decodificação dos campos da instrução |
| `ImmediateGenerator_32` | Geração de valores imediatos |
| `ControlUnit_32` | Geração de sinais de controle |
| `RegisterFile_32` | Banco de 32 registradores |
| `ID_EX_Register` | Registrador de pipeline ID/EX |
| `ALU_32` | Operações aritméticas e lógicas |
| `ALUControl_32` | Seleção da operação da ALU |
| `ALUSrcMux_32` | Seleção do segundo operando da ALU |
| `ALUInputAMux_32` | Seleção do primeiro operando para instruções como AUIPC |
| `ForwardingUnit_32` | Controle do encaminhamento de dados |
| `ForwardAMux_32` | Seleção do primeiro operando encaminhado |
| `ForwardBMux_32` | Seleção do segundo operando encaminhado |
| `HazardDetectionUnit_32` | Detecção de dependências load-use |
| `EX_MEM_Register` | Registrador de pipeline EX/MEM |
| `DataMemory_32` | Memória de dados |
| `MEM_WB_Register` | Registrador de pipeline MEM/WB |
| `WriteBackMux_32` | Seleção do resultado para escrita |
| `BranchJumpUnit_32` | Lógica de desvios e saltos |
| `NextPCMux_32` | Seleção do próximo PC |

Os nomes apresentados identificam os módulos utilizados no circuito. Os arquivos Verilog correspondentes devem estar disponíveis na pasta do projeto.

## 7. Executando um programa

As instruções são fornecidas no arquivo `program.hex`, em formato hexadecimal, com uma instrução de 32 bits por linha.

Exemplo:

```text
00A00093
00300113
002081B3
40208233
```

Esse programa corresponde a:

```asm
addi x1, x0, 10
addi x2, x0, 3
add  x3, x1, x2
sub  x4, x1, x2
```

### Procedimento de execução

1. Abra `program.hex` e insira o programa desejado.
2. Salve o arquivo.
3. Abra `CPU_RISCV.dig` no Digital.
4. Inicie a simulação.
5. Ative e desative o sinal `reset`.
6. Execute os ciclos de clock, alternando `0 → 1 → 0`.
7. Observe os resultados nas saídas de diagnóstico.

**Importante:** para carregar um programa diferente, pare a simulação, atualize `program.hex` e inicie uma nova simulação.

### Resultado esperado do exemplo

| Registrador | Valor hexadecimal | Decimal |
|---|---|---|
| x1 | `0000000A` | 10 |
| x2 | `00000003` | 3 |
| x3 | `0000000D` | 13 |
| x4 | `00000007` | 7 |

O programa testa operações aritméticas consecutivas com dependências de dados, sem instruções NOP.

## 8. Testes realizados

Foram realizados testes funcionais e de integração para as 21 instruções implementadas.

| Teste | Instruções | Resultado |
|---|---|---|
| Aritmética | ADD, ADDI, SUB | Aprovado |
| Operações lógicas | AND, OR | Aprovado |
| Lógicas com imediato | ANDI, ORI | Aprovado |
| XOR | XOR, XORI | Aprovado |
| Deslocamento à esquerda | SLL, SLLI | Aprovado |
| Deslocamento à direita | SRL, SRLI | Aprovado |
| Acesso à memória | LW, SW | Aprovado |
| Dependência load-use | LW seguido de ADD | Aprovado |
| Desvio por igualdade | BEQ | Aprovado |
| Desvio por diferença | BNE | Aprovado |
| Salto direto | JAL | Aprovado |
| Salto indireto | JALR | Aprovado |
| Imediato superior | LUI | Aprovado |
| PC relativo | AUIPC | Aprovado |

Os testes incluíram instruções consecutivas e dependências de dados, validando o funcionamento dos mecanismos de forwarding e controle de hazards nos cenários executados.

Os resultados foram verificados por meio das saídas de diagnóstico do banco de registradores.

### Saídas de diagnóstico

| Saída | Conteúdo |
|---|---|
| `DebugX1` | Valor armazenado em x1 |
| `DebugX3` | Valor armazenado em x3 |
| `DebugX4` | Valor armazenado em x4 |

Essas saídas permitem acompanhar os resultados durante a simulação sem alterar o fluxo de execução.

## 9. Estado atual do projeto

A CPU possui os cinco estágios de pipeline implementados e integrados, com suporte às 21 instruções listadas.

Foram validados:

- Execução de instruções aritméticas e lógicas.
- Operações com valores imediatos.
- Deslocamentos lógicos.
- Leitura e escrita na memória.
- Encaminhamento de dados entre estágios.
- Dependências entre instruções consecutivas.
- Detecção de dependências load-use.
- Desvios condicionais e saltos.
- Instruções LUI e AUIPC.

**Limitação:** os testes realizados verificam os cenários funcionais descritos, mas não constituem uma verificação exaustiva de todas as combinações de instruções, hazards e casos-limite da arquitetura RV32I.

## 10. Observações

- O projeto utiliza o simulador Digital e módulos externos em Verilog.
- Os caminhos dos arquivos externos podem precisar de atualização em outros computadores.
- O arquivo `program.hex` determina o programa executado pela CPU.
- As instruções são representadas em hexadecimal, com 32 bits por instrução.
- O banco de registradores possui 32 registradores de 32 bits, sendo `x0` fixo em zero.
- A implementação foi desenvolvida para fins acadêmicos, com foco na arquitetura de processadores e na execução pipeline.