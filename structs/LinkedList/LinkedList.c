#include "LinkedList.h"

linkedlist_t *new_linkedlist() {
    linkedlist_t *ll = malloc(sizeof(linkedlist_t));
    if (ll == NULL)
        return NULL;

    ll->next = NULL;
    ll->_is_init = false;

    return ll;
}

int init_linkedlist(linkedlist_t *ll, void *data, size_t datasize) {
    ll->data = malloc(datasize);
    if (ll->data == NULL)
        return 1;

    ll->_is_init = true;

    memcpy(ll->data, data, datasize);
    ll->next = NULL; 

    return 0;
}

void destroy_linkedlist(linkedlist_t *ll) {
    linkedlist_t *next = NULL;
    while (ll != NULL) {
        next = ll->next;
        if (ll->_is_init) 
            free(ll->data);
        free(ll);
        ll = next;
    }
}

linkedlist_t *tail_linkedlist(linkedlist_t *ll) {
    while (ll->next != NULL)
        ll = ll->next;

    return ll;
}

int push_linkedlist(linkedlist_t *ll, void *data, size_t datasize) {
    linkedlist_t *newll, *tail = tail_linkedlist(ll);
    if (tail == NULL)
        return 1;

    if (tail->_is_init) {
        newll = new_linkedlist();
        if (newll == NULL)
            return 1;

        tail->next = newll;
    } else {
        newll = tail;
    }

    return init_linkedlist(newll, data, datasize);   
}

void *pop_linkedlist(linkedlist_t *ll) {
    void *data = NULL;
    linkedlist_t *prev = NULL;
    while (ll->next != NULL) {
        prev = ll;
        ll = prev->next;
    }

    data = ll->data;
    if (prev != NULL)
        prev->next = NULL;

    destroy_linkedlist(ll);
    return data;
}