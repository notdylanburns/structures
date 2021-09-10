CC := gcc

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
INC_DIR := $(ROOT_DIR)/inc
LIB_DIR := $(ROOT_DIR)/lib
OBJ_DIR := $(ROOT_DIR)/obj
STRUCT_DIR := $(ROOT_DIR)/structs

SYS_INC_DIR := /usr/include/structures
SYS_LIB_DIR := /usr/lib
SYS_BIN_DIR := /usr/bin

DIRS := $(INC_DIR) $(LIB_DIR) $(OBJ_DIR)
SRC_DIRS := $(shell find $(STRUCT_DIR) -mindepth 1 -maxdepth 1 -type d)
NAMES := $(foreach dir, $(SRC_DIRS), $(notdir $(dir)))
OBJS := $(foreach n, $(NAMES), $(OBJ_DIR)/$(n).o)
LIBS := $(foreach n, $(NAMES), $(LIB_DIR)/lib$(n).so)
HEDS := $(foreach n, $(NAMES), $(INC_DIR)/$(n).h)

OBJ_TARGET := obj
LIB_TARGET := lib
CLEAN_TARGET := clean

TARGET := $(LIB_DIR)/libstructures.so

LDFLAGS := 

all: $(DIRS) $(LIBS) $(HEDS) $(TARGET) clean
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -shared -o $@ $^

$(OBJ_DIR)/%.o: %
	$(MAKE) $(OBJ_TARGET) -C $(STRUCT_DIR)/$<
	cp $(STRUCT_DIR)/$</$<.o $@

$(LIB_DIR)/lib%.so: %
	$(MAKE) $(LIB_TARGET) -C $(STRUCT_DIR)/$<
	cp $(STRUCT_DIR)/$</$<.so $@

$(INC_DIR)/%.h: %
	cp $(STRUCT_DIR)/$</$<.h $@

$(NAMES): 
#	$(MAKE) -C $(STRUCT_DIR)/$@

$(DIRS):
	mkdir $@

clean:
	rm -rf $(OBJ_DIR)
	for n in $(NAMES); do $(MAKE) $(CLEAN_TARGET) -C $(STRUCT_DIR)/$$n; done

cleanall: clean
	rm -rf $(DIRS)

install: $(SYS_INC_DIR) $(SYS_LIB_DIR)
	cp $(INC_DIR)/* $(SYS_INC_DIR)
	cp $(LIB_DIR)/* $(SYS_LIB_DIR)

$(SYS_INC_DIR) $(SYS_LIB_DIR):
	mkdir $@

.PHONY: all