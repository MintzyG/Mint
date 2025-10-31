#include "types.h"
#include <stdio.h> 

void print_id_list(IdList *list) {
  printf("ID_LIST(");
  for (int i = 0; i < list->Size; i++) {
    printf("%s, ", list->IDs[i]);
  }
  printf(")\n");
}

void print_var_decl(VarDecl *decl) {
  printf("VAR_DECL(\n");
  for (int i = 0; i < decl->IdList.Size; i++) {
    printf("  %s: %s\n", decl->IdList.IDs[i], base_type_to_string(decl->Type));
  }
  printf(");\n");
}

const char* base_type_to_string(BaseType type) {
  switch (type) {
    case TYPE_I8:
      return "i8";
    case TYPE_I16:
      return "i16";
    case TYPE_INT:
    case TYPE_I32:
      return "i32";
    case TYPE_I64:
      return "i64";
    case TYPE_I128:
      return "i128";
    case TYPE_U8:
      return "u8";
    case TYPE_U16:
      return "u16";
    case TYPE_U32:
      return "u32";
    case TYPE_U64:
      return "u64";
    case TYPE_U128:
      return "u128";
    case TYPE_BOOL:
      return "bool";
    case TYPE_CHAR:
      return "char";
    case TYPE_STRING:
      return "string";
    case TYPE_PATH:
      return "path";
    case TYPE_F32:
    case TYPE_FLOAT:
      return "f32";
    case TYPE_F64:
      return "f64";
    default:
      return "UNKOWN_ERROR";
  }
}


