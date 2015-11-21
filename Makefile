all: encode decode testN

testN: testN.o simprob_utils.o number_utils.o probabilidad.o huffman_tree.o huffman_table.o huffman.o coder.o string_analyzer.o string_utils.o string_list.o string_value_list.o
	gcc -Wall -g -pg -o testN testN.o simprob_utils.o number_utils.o probabilidad.o huffman_tree.o huffman_table.o huffman.o coder.o string_analyzer.o string_utils.o string_list.o string_value_list.o -lm

testN.o: testN.c
	gcc -Wall -g -pg -o testN.o -c testN.c

decode: decode.o simprob_utils.o number_utils.o probabilidad.o huffman_tree.o huffman_table.o huffman.o coder.o string_analyzer.o string_utils.o string_list.o string_value_list.o
	gcc -Wall -g -pg -o decode decode.o simprob_utils.o number_utils.o probabilidad.o huffman_tree.o huffman_table.o huffman.o coder.o string_analyzer.o string_utils.o string_list.o string_value_list.o -lm

decode.o: decode.c huffman_table.h huffman_table.c
	gcc -Wall -g -pg -o decode.o -c decode.c

encode: encode.o simprob_utils.o number_utils.o probabilidad.o huffman_tree.o huffman_table.o huffman.o coder.o string_analyzer.o string_utils.o string_list.o string_value_list.o
	gcc -Wall -g -pg -o encode encode.o simprob_utils.o number_utils.o probabilidad.o huffman_tree.o huffman_table.o huffman.o coder.o string_analyzer.o string_utils.o string_list.o string_value_list.o -lm

encode.o: encode.c simprob_utils.c simprob_utils.h number_utils.c number_utils.h coder.c coder.h
	gcc -Wall -g -pg -o encode.o -c encode.c

simprob_utils.o: simprob_utils.c simprob_utils.h number_utils.c number_utils.h
	gcc -Wall -g -pg -o simprob_utils.o -c simprob_utils.c

number_utils.o: number_utils.c number_utils.h
	gcc -Wall -g -pg -o number_utils.o -c number_utils.c

probabilidad.o: probabilidad.h probabilidad.c
	gcc -Wall -g -pg -o probabilidad.o -c probabilidad.c

huffman.o: huffman.c huffman.h huffman_tree.c huffman_tree.h huffman_table.h huffman_table.c
	gcc -Wall -g -pg -o huffman.o -c huffman.c

huffman_table.o: huffman_table.h huffman_table.c huffman_tree.c huffman_tree.h
	gcc -Wall -g -pg -o huffman_table.o -c huffman_table.c

huffman_tree.o: huffman_tree.h huffman_tree.c
	gcc -Wall -g -pg -o huffman_tree.o -c huffman_tree.c

coder.o: coder.c coder.h huffman_table.c huffman_table.h string_utils.c string_utils.h
	gcc -Wall -g -pg -o coder.o -c coder.c 

string_analyzer.o: string_analyzer.h string_analyzer.c
	gcc -Wall -g -pg -o string_analyzer.o -c string_analyzer.c

string_utils.o: string_utils.h string_utils.c
	gcc -Wall -g -pg -o string_utils.o -c string_utils.c

string_list.o: string_list.h string_list.c
	gcc -Wall -g -pg -o string_list.o -c string_list.c

string_list_value.o: string_value_list.h string_value_list.c
	gcc -Wall -g -pg -o string_value_list.o -c string_value_list.c

clean:
	rm *.o encode decode testN
