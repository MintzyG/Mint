#pragma once

#include <stdlib.h>

typedef enum {
    TYPE_INT, TYPE_I8, TYPE_I16, TYPE_I32, TYPE_I64, TYPE_I128,
    TYPE_U8, TYPE_U16, TYPE_U32, TYPE_U64, TYPE_U128,
    TYPE_BOOL,
    TYPE_CHAR, TYPE_STRING,
    TYPE_PATH,
    TYPE_FLOAT, TYPE_F32, TYPE_F64
} BaseType;

typedef struct {
    char* id;
} Identifier;

typedef struct {
    Identifier* items;
    int size;
} IdentifierList;

typedef struct {
    IdentifierList name_list;
    BaseType type;
} Param;

typedef struct {
    Param* list;
    int size;
} ParamList;

typedef struct {
    char* name;
    ParamList params;
    ParamList returns;
} Function;
