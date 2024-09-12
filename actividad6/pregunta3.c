#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

void* funcion_hilo(void* arg) {
    printf("Hilo creado en el proceso con PID: %d\n", getpid());
    return NULL;
}

int main() {
    pid_t pid;
    pthread_t thread;


    pid = fork();
    
    //Proceso hijo
    if (pid == 0) {
        //Segundo fork dentro del proceso hijo
        fork();

        //Creación de un hilo en el proceso hijo
        pthread_create(&thread, NULL, funcion_hilo, NULL);
        pthread_join(thread, NULL);  
    }

    //Tercer fork ejecutado tanto por el padre, el hijo
    fork();

    //Pausa para visualizar los PIDs y procesos creados
    sleep(1);
    printf("Proceso con PID: %d\n", getpid());

    return 0;
}
