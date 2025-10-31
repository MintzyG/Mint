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

const char* base_type_to_string(BaseType type);

typedef struct {
  char **IDs;
  int Size;
} IdList;

void print_id_list(IdList *list);

typedef struct {
  BaseType Type;
  IdList IdList;
} VarDecl;

void print_var_decl(VarDecl *decl);

