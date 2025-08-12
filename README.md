# libasm

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
