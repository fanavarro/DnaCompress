#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "simprob_utils.h"
#include "huffman_table.h"
#include "coder.h"
#include "string_value_list.h"
#include "string_utils.h"
#include "huffman.h"
#include "string_analyzer.h"
#define BYTES_PER_SYMBOL 8
char* huffmanSimple(char *input);
char* huffmanComplex(char *input);
//GTAGTGTAATGCAACATCGCACATGGGGTAGATCGCAATATATAGGGAACTAGAATGCGACTAGGCAGTTCTACTGAGCAAGAGGAGTCCTGGATTCTGCCAGCCGATCCTTATGCACGTGAGCGACATTCGAAATGACATGATGGCCTTCAATTGTCCCCAACGGGTGATGCAGTGTCGCAGTTGGCATGCACGGTTAATACGATGCCTTGAGGTTCCTCAGCCTAGCGCCCATTTGGCGGT
int main(void)
{
	double a = 0.25;
	double t = 0.25;
	double c = 0.25;
	double g = 0.25;
	int n = 300;
	int start = 10;
	double rcSimple [n - start];
	double rcComplex [n - start];
	int len [n - start];

	char *seq = NULL;
	char *binSimple = NULL;
	char *binComplex = NULL;
	int size = -1;
	for(int i = start; i < n; i++){
		size = i * BYTES_PER_SYMBOL;
		seq = createDnaString(a, g, c, t, i);

		binSimple = huffmanSimple(seq);
		binComplex = huffmanComplex(seq);
		
		len[i - start] = i;
		rcSimple[i - start] = (double)size/(double)(strlen(binSimple));
		rcComplex[i - start] = (double)size/(double)(strlen(binComplex));
		printf("%d\t%.3f\t%.3f\n", len[i-start], rcSimple[i-start], rcComplex[i-start]);

		free(binSimple);
		free(binComplex);
		free(seq);
	}
	//printf("n\tsimple\tcomplex\n");
	//for(int i = 0; i < n-start; i++){
		//printf("%d\t%.3f\t%.3f\n", len[i], rcSimple[i], rcComplex[i]);
	//}

	return 0;
}

char* huffmanSimple(char *input)
{
	char *alphabet[] = {"A", "T", "C", "G"};
	double *symbolFrequency = charFreq(input, "ATCG");
	HuffmanTable *table = huffman(symbolFrequency, alphabet, 4);
	char *bin = getBinaryString(input, table);
	freeHuffmanTable(table);
	free(symbolFrequency);
	return bin;
}

char* huffmanComplex(char *input)
{
	char *alphabet = "ATCG";
	StringValueList *symbols = groupSymbols(input, alphabet);
	HuffmanTable *table = huffman(symbols->value, symbols->string, symbols->length);
	char *bin = getBinaryString(input, table);
	freeStringValueList(symbols);
	freeHuffmanTable(table);
	return bin;
}
