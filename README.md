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
| Instrucción | Significado                | ¿Para qué se usa?                                   |
| ----------- | -------------------------- | --------------------------------------------------- |
| `mov`       | Copiar un valor            | `mov rax, 0` pone 0 en `rax`, `mov rax, rdi` copia  |
| `xor`       | Operación XOR              | `xor rax, rax` para poner `rax = 0` (muy usado)     |
| `cmp`       | Comparar                   | Para ver si dos valores son iguales/diferentes      |
| `je`        | Jump if Equal              | Saltar si dos valores eran iguales (`cmp` ==)       |
| `jne`       | Jump if Not Equal          | Saltar si son distintos                             |
| `jmp`       | Salto incondicional        | Para repetir bucles o saltar a partes del código    |
| `inc`       | Incrementar (sumar 1)      | `inc rax` → suma 1                                  |
| `dec`       | Decrementar (restar 1)     | `dec rax` → resta 1                                 |
| `ret`       | Return                     | Finaliza la función                                 |
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

movzx → rellena con ceros (para unsigned)

movsx → rellena con el signo (para signed)
