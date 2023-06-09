CC=cc
CCOPT=-Wall 
DFLAGS=-D_DEBUG_=1 
IOPT=-I ./include -I ./SHA3IUF/
LDFLAGS=-lcrypto SHA3IUF/libsha3.a
all: generate_shares encrypt encrypt2 compute_share_for_withdrawal witness_for_withdrawal
install: all
generate_shares.o: src/generate_shares.c
	$(CC) -o src/generate_shares.o -c src/generate_shares.c $(IOPT) $(CCOPT)
cyclic_group.o: src/cyclic_group.c
	$(CC) -o src/cyclic_group.o -c src/cyclic_group.c $(IOPT) $(CCOPT)
generate_shares: generate_shares.o cyclic_group.o
	$(CC) -o bin/generate_shares  src/generate_shares.c src/cyclic_group.o $(IOPT) $(LDFLAGS) $(CCOPT)
encrypt: src/encrypt.c cyclic_group.o
	$(CC) -o bin/encrypt  src/encrypt.c src/cyclic_group.o $(IOPT) $(LDFLAGS) $(CCOPT)
encrypt2: src/encrypt2.c cyclic_group.o
	$(CC) -o bin/encrypt2  src/encrypt2.c src/cyclic_group.o $(IOPT) $(LDFLAGS) $(CCOPT)
compute_share_for_withdrawal: src/compute_share_for_withdrawal.c cyclic_group.o
	$(CC) -o bin/compute_share_for_withdrawal  src/compute_share_for_withdrawal.c src/cyclic_group.o $(IOPT) $(LDFLAGS) $(CCOPT)
witness_for_withdrawal: src/witness_for_withdrawal.c cyclic_group.o
	$(CC) -o bin/witness_for_withdrawal  src/witness_for_withdrawal.c src/cyclic_group.o $(IOPT) $(LDFLAGS) $(CCOPT)
clean:
	rm -f bin/* src/*.o 
