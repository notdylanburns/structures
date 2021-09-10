#ifndef _LINKEDLIST_H_GUARD_
#define _LINKEDLIST_H_GUARD_

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct LinkedList {
    void *data;
    size_t datasize;
    struct LinkedList *next;
    bool _is_init;
};

typedef struct LinkedList linkedlist_t;

extern linkedlist_t *new_linkedlist();
extern int init_linkedlist(linkedlist_t *ll, void *data, size_t datasize);
extern void destroy_linkedlist(linkedlist_t *ll);

extern linkedlist_t *tail_linkedlist(linkedlist_t *ll);
extern int push_linkedlist(linkedlist_t *ll, void *data, size_t datasize);
extern void *pop_linkedlist(linkedlist_t *ll);

#endif