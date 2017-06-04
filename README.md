# Phased Cache Design with FIFO replacement policy and write back policy

This is the implementation of a phased cache in Verilog, which can be simulated in ModelSim Altera.

The cache was designed and implemented as a part of a course on Computer Architecture.

Cache size = 512 B

Cache line size = 16 B

Number of cache lines = 32

Associativity = 8


The testbench works on the assumption that the cache holds certain values (a snapshot of the cache) at some point of time.

The 'init' parameters are used to set the values present in the cache at that time.


*32-bit physical address*

Cache line size = 16B; Offset = 4 bits

No. of cache lines = 512B/16B = 32 blocks

Associativity = 8 way

No. of sets = 32/8 = 4; Index = 2 bits

Tag = 32 - 4 - 2 = 26 bits

So Tag = 26 bits, Index = 2 bits, Offset = 4 bits.

*Total Cache Size*
 
Data = 512B

Valid bits = 1 x 32 = 32 bits = 4B

Dirty bits = 1 x 32 = 32 bits = 4B

Tag array = 26 x 32 = 104B

Counters = 3 x 32 = 12B

So total size = 636B.

*Test cases in the test bench*
 
Read hits = 3

Read misses = 1

Write hits = 1

Write misses = 1
