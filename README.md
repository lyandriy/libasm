# libasm


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
