#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid;

    // Crear proceso hijo
    pid = fork();

    if (pid < 0) {
        //Error al crear el proceso
        perror("El proceso fork failed");
        exit(1);
    } else if (pid == 0) {
        //creando el proceso hijo
        printf("Proceso hijo (PID: %d) terminado.\n", getpid());
        exit(0); // El proceso hijo termina inmediatamente
    } else {
        //creado proceso padre
        printf("Proceso padre (PID: %d), hijo (PID: %d) creado.\n", getpid(), pid);

        // Espera de 60 segundos mientras el proceso hijo está en estado zombie
        sleep(60);

        //Recoger el proceso hijo zombie
        wait(NULL);

        printf("Proceso zombie recogido (PID: %d).\n", pid);
    }

    return 0;
}
