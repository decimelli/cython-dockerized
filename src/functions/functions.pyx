#cython: language_level=3

def say_hello_to(name):
    print("Hello %s!" % name)

def find_primes(int amount):
    cdef int number
    cdef int x
    cdef int found
    cdef int primes[100000]

    amount = min(amount, 100000)

    found = 0
    number = 2
    while found < amount:
        for x in primes[:found]:
            if number % x == 0:
                break
        else:
            primes[found] = number
            found += 1

        number += 1

    result = [p for p in primes[:found]]
    return result
