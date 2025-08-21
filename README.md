# libasm

📦 1. Los registros ya existen en el hardware
Cuando escribes en ensamblador, estás hablando directamente con el procesador, que ya tiene estos registros definidos por arquitectura.

En x86-64 (64 bits), tienes:
🧠 REGISTROS MÁS USADOS EN x86_64 (modo 64 bits)
| Registro                      | Uso típico                                          | Comentario fácil                               |
| ----------------------------- | --------------------------------------------------- | ---------------------------------------------- |
| `rax`                         | Acumulador, se usa para devolver resultados         | Devuelves cosas por aquí (como `return`)       |
| `rdi`                         | Primer argumento de una función                     | Aquí entra el primer parámetro                 |
| `rsi`                         | Segundo argumento de una función                    | Aquí entra el segundo parámetro                |
| `rdx`                         | Tercer argumento                                    | Otro parámetro                                 |
| `rcx`                         | Cuarto argumento                                    | Se usa también como contador a veces           |
| `r8`                          | Quinto argumento                                    | Solo si usas más de 4 argumentos               |
| `r9`                          | Sexto argumento                                     | Igual que el anterior                          |
| `rsp`                         | Stack Pointer (puntero a la pila)                   | ¡NO LO TOQUES! A menos que sepas lo que haces  |
| `rbp`                         | Base Pointer (inicio del marco de pila actual)      | Para acceder a variables locales (si las usas) |
| `rsi`, `rdi`, `rax`, `rdx`... | También se usan en llamadas a `write`, `read`, etc. | Muy útiles en syscall                          |

🛑 IMPORTANTE: En este proyecto no usas la pila ni funciones con más de 2 parámetros, así que te basta rdi, rsi, rax, rdx en la mayoría de los casos.

En ensamblador, cada registro de 64 bits (como rax, rbx, etc.) se puede dividir en partes más pequeñas:
| 64 bits    | 32 bits | 16 bits | 8 bits | Uso común                             |
| ---------- | ------- | ------- | ------ | ------------------------------------- |
| `rax`      | `eax`   | `ax`    | `al`   | resultado, acumulador                 |
| `rbx`      | `ebx`   | `bx`    | `bl`   | uso general                           |
| `rcx`      | `ecx`   | `cx`    | `cl`   | contador de bucles                    |
| `rdx`      | `edx`   | `dx`    | `dl`   | segundo resultado                     |
| `rsi`      | `esi`   | `si`    | `sil`  | segundo argumento (string source)     |
| `rdi`      | `edi`   | `di`    | `dil`  | primer argumento (string destination) |
| `rsp`      | `esp`   | `sp`    | `spl`  | stack pointer (pila)                  |
| `rbp`      | `ebp`   | `bp`    | `bpl`  | base pointer                          |
| `r8`-`r15` | ...     | ...     | ...    | registros extra                       |

Entonces:
al es la parte baja (low) de rax, solo 1 byte (8 bits).
bl es la parte baja de rbx.

🧩 2. Los registros se dividen por tamaño:
Tú decides qué parte del registro usar, dependiendo del tamaño de los datos:

Tipo de dato	Tamaño	Registro recomendado
char	1 byte	al, bl, cl...
int	4 bytes	eax, ebx...
dirección	8 bytes	rax, rbx...

Por ejemplo:
mov al, [rdi]    ; cargar 1 byte desde dirección en rdi
mov eax, [rdi]   ; cargar 4 bytes
mov rax, [rdi]   ; cargar 8 bytes


⚙️ INSTRUCCIONES MÁS USADAS
| Instrucción | Descripción                  | Ejemplo / Explicación                                                                                                     |
| ----------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `mov`       | Copiar un valor              | `mov rax, 0` pone 0 en `rax`; `mov rax, rdi` copia `rdi` a `rax`; `mov al, byte [rsi]` copia un byte desde memoria a `al` |
| `xor`       | XOR bit a bit                | `xor rax, rax` pone `rax = 0` (muy usado para inicializar registros)                                                      |
| `cmp`       | Comparar valores             | `cmp al, 0` compara `al` con 0, afectando flags (para usar con `je`, `jne`...)                                            |
| `je`        | Salto si igual               | `je end_loop` salta a `end_loop` si la comparación anterior fue igual (`ZF=1`)                                            |
| `jne`       | Salto si distinto            | `jne loop` salta si la comparación anterior fue distinta (`ZF=0`)                                                         |
| `inc`       | Incrementar                  | `inc rsi` aumenta `rsi` en 1 (útil para moverse por arrays o cadenas)                                                     |
| `dec`       | Decrementar                  | `dec rdi` reduce `rdi` en 1                                                                                               |
| `add`       | Sumar                        | `add rax, rbx` suma `rbx` a `rax`                                                                                         |
| `sub`       | Restar                       | `sub rax, rbx` resta `rbx` de `rax`                                                                                       |
| `push`      | Guardar en stack             | `push rdi` guarda `rdi` en la pila (útil antes de llamar a otra función o para preservar registros)                       |
| `pop`       | Sacar del stack              | `pop rdi` restaura el valor previamente guardado en stack                                                                 |
| `jmp`       | Salto incondicional          | `jmp loop` salta sin condición a la etiqueta `loop`                                                                       |
| `movsx`     | Mover con extensión de signo | `movsx rax, al` convierte un byte `al` en entero de 64 bits con signo                                                     |
| `movzx`     | Mover con extensión de cero  | `movzx rax, al` convierte un byte `al` en entero de 64 bits sin signo                                                     |
| `ret`       | Retornar de función          | Devuelve al llamador; el valor de retorno debe estar en `rax`                                                             |
| `nop`       | No hacer nada                | `nop` no hace nada; útil para alineación o depuración                                                                     |
| `lea`       | Load effective address       | `lea rax, [rdi+4]` calcula la dirección `rdi+4` y la guarda en `rax`, sin acceder a memoria                               |
| `syscall`   | Llama al sistema operativo | Usado para `write`, `read`, etc. (como funciones C) |

🆚 Diferencias clave entre test y cmp:
| Instrucción | Qué hace                                                                        | Cuándo se usa                                                                  |
| ----------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| `cmp A, B`  | Hace `A - B` (resta) y **actualiza los flags**, **pero no guarda el resultado** | Cuando quieres saber si `A == B`, `A > B`, `A < B`, etc.                       |
| `test A, B` | Hace `A AND B` (bit a bit) y actualiza los flags, **sin guardar el resultado**  | Cuando quieres saber si algún bit de A (o A y B) está encendido, o si `A == 0` |

🧠 Truco para recordar:

🔹 cmp compara valores completos.

🔹 test comprueba si hay bits encendidos, como para verificar si algo es 0.

✅ ¿Qué hace movzx?
movzx significa "Move with Zero-Extension".

"Move" → copia un valor de un registro (más pequeño) a uno más grande.

"Zero-Extension" → rellena los bits que faltan con ceros.
🧠 ¿Por qué se usa?
Cuando trabajas con strings (char, 1 byte), los cargas en registros pequeños como al, bl...

Pero muchas instrucciones (como sub, cmp, etc.) necesitan trabajar con registros de 32 o 64 bits para no tener resultados raros por tamaños distintos.

Tienes que decirle explícitamente cómo rellenar los bits restantes. Para eso existen:

|movzx → rellena con ceros (para unsigned)|
|movsx → rellena con el signo (para signed)|

cuando accedes a memoria con [rdi], el ensamblador necesita saber cuántos bytes leer:
|                  |
| ---------------- |
|¿1 byte? (byte)   |
|¿2 bytes? (word)  |
|¿4 bytes? (dword) |
|¿8 bytes? (qword) |

📜 Tabla de saltos en ensamblador x86-64
| Instrucción | Significado (inglés)     | Cuándo salta (`cmp a, b`)                  | Interpretación habitual       |
| ----------- | ------------------------ | ------------------------------------------ | ----------------------------- |
| `je`        | Jump if Equal            | Si **a == b** (flag ZF=1)                  | Igual que en C: `if (a == b)` |
| `jne`       | Jump if Not Equal        | Si **a != b** (ZF=0)                       | `if (a != b)`                 |
| `jg`        | Jump if Greater          | Si **a > b** (solo para enteros con signo) | `if (a > b)`                  |
| `jge`       | Jump if Greater or Equal | Si **a >= b** (con signo)                  | `if (a >= b)`                 |
| `jl`        | Jump if Less             | Si **a < b** (con signo)                   | `if (a < b)`                  |
| `jle`       | Jump if Less or Equal    | Si **a <= b** (con signo)                  | `if (a <= b)`                 |
| `ja`        | Jump if Above            | Si **a > b** (sin signo)                   | Para comparar `unsigned`      |
| `jae`       | Jump if Above or Equal   | Si **a >= b** (sin signo)                  | `unsigned` >=                 |
| `jb`        | Jump if Below            | Si **a < b** (sin signo)                   | `unsigned` <                  |
| `jbe`       | Jump if Below or Equal   | Si **a <= b** (sin signo)                  | `unsigned` <=                 |
| `jmp`       | Jump (unconditional)     | Siempre salta                              | Goto                          |
| `jz`        | Jump if Zero             | Igual que `je`                             | Salta si resultado es cero    |
| `jnz`       | Jump if Not Zero         | Igual que `jne`                            | Salta si resultado no es cero |
| `js`        | Jump if Sign             | Si el resultado es negativo (SF=1)         |                               |
| `jns`       | Jump if Not Sign         | Si el resultado no es negativo (SF=0)      |                               |

🔹 Directivas más comunes que podrías encontrar
| Directiva | Para qué sirve                                                 | Ejemplo               |
| --------- | -------------------------------------------------------------- | --------------------- |
| `section` | Indica en qué parte del ejecutable va el código o datos        | `section .text`       |
| `global`  | Hace que una etiqueta sea visible desde fuera del archivo      | `global ft_strlen`    |
| `extern`  | Declara que una función/variable está definida en otro archivo | `extern malloc`       |
| `db`      | Define datos en memoria (bytes)                                | `msg db "Hola", 0`    |
| `dw`      | Define un valor de 2 bytes (*word*)                            | `num dw 1234`         |
| `dd`      | Define un valor de 4 bytes (*double word*)                     | `valor dd 0x12345678` |
| `dq`      | Define un valor de 8 bytes (*quad word*)                       | `grande dq 123456789` |
| `resb`    | Reserva bytes en la sección `.bss` (no inicializados)          | `buffer resb 64`      |
| `resw`    | Reserva palabras de 2 bytes                                    | `arr resw 10`         |
| `resd`    | Reserva dobles palabras de 4 bytes                             | `arr resd 20`         |
| `resq`    | Reserva cuádruples palabras de 8 bytes                         | `arr resq 5`          |
| `equ`     | Crea una constante                                             | `BUF_SIZE equ 256`    |
| `%define` | Macro que sustituye texto, similar a `#define` en C            | `%define MAX 100`     |

