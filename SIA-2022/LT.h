#pragma once

#include "stdafx.h"

#define	LEXEMA_FIXSIZE  1
#define LT_MAXSIZE		4096
#define LT_TI_NULLIDX	0xffffffff
#define LEX_INTEGER		't'
#define LEX_STRING		't'
#define LEX_ID			'i'
#define	LEX_LITERAL		'l'
#define LEX_FUNCTION	'f'
#define LEX_DECLARE		'd'
#define LEX_RETURN		'r'
#define LEX_PRINT		'P'
#define LEX_SEMICOLON	';'   
#define LEX_COMMA		','
#define LEX_LEFTBRACE	'{'
#define LEX_BRACELET	'}'
#define LEX_RIGHTHESIS	')'
#define LEX_LEFTHESIS	'('
#define LEX_PLUS		'v'
#define LEX_MINUS		'v'
#define LEX_STAR		'v'
#define LEX_DIRSLASH	'v'


namespace LT
{
	struct Entry	// строка таблицы лексем
	{
		char lexema[LEXEMA_FIXSIZE];
		int sn;
		int idxTI;
	};

	struct LexTable	// экземплр таблицы лексем
	{
		int maxsize;
		int size;
		Entry* table;
	};

	LexTable Create(int size);
	void Add(LexTable& lextable, Entry entry);
	Entry GetEntry(LexTable& lextable, int n);
	void Delete(LexTable& lextable);
}