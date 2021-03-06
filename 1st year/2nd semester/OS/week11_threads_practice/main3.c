//
// lock_3.c - Using a mutex (mutual exclusion lock)
//
// pthread_mutex_lock()   - acquire a lock on the specified mutex variable. If the mutex is already locked by another thread,
//                          this call will block the calling thread until the mutex is unlocked.
//
// pthread_mutex_unlock() - unlock a mutex variable. An error is returned if mutex is already unlocked or owned by another thread.
//

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

//
// input 10 numbers and print them
//

#define MAX_READ  1   // maximun number of readers
#define MAX_WRITE 1    // maximun number of writers

int v[100] = {};

pthread_mutex_t mtx;    // a mutex

//
// Readers start routine
//
void* check(void* a)
{
    int k = (int)a;

    pthread_mutex_lock(&mtx);         // lock

	for (int i = 0; i < 10; ++i) scanf("%d", &v[i]);

    pthread_mutex_unlock(&mtx);       // unlock

    return NULL;
}

//
// Writers start routine
//
void* buy(void* a)
{
    int k = (int)a;

    pthread_mutex_lock(&mtx);         // lock


	int num;
	printf("read num to check: ");
	scanf("%d", &num);
    for (int i = 0; i < 10; ++i)
		if (v[i] % num == 0) printf("%d mod %d == 0\n", v[i], num);
	printf("end writer -------------\n");

    pthread_mutex_unlock(&mtx);       // unlock

    return NULL;
}



int main(int argc, char* argv[])
{
    pthread_t tr[MAX_READ];
    pthread_t tw[MAX_WRITE];

    pthread_mutex_init(&mtx, NULL);   // init the mutex

    int i;
    for (i = 0; i < MAX_READ; i++)
    {
        pthread_create(&tr[i], NULL,
                       check, (void*)i);             // create readers
    }

    for (i = 0; i < MAX_WRITE; i++)
    {
        pthread_create(&tw[i], NULL,
                       buy, (void*)i);               // create writers
    }

    for (i = 0; i < MAX_READ; i++)
    {
        pthread_join(tr[i], NULL);      // wait for readers to finish
    }

    for (i = 0; i < MAX_WRITE; i++)
    {
        pthread_join(tw[i], NULL);      // wait for writers to finish
    }

    pthread_mutex_destroy(&mtx);      // destroy the mutex

    return 0;
}
