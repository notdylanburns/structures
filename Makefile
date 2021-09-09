CC := gcc

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
INC_DIR := $(ROOT_DIR)/inc
LIB_DIR := $(ROOT_DIR)/lib
OBJ_DIR := $(ROOT_DIR)/obj
STRUCT_DIR := $(ROOT_DIR)/structs

DIRS := $(INC_DIR) $(LIB_DIR) $(OBJ_DIR)
SRC_DIRS := $(shell find $(STRUCT_DIR) -mindepth 1 -maxdepth 1 -type d)
NAMES := $(foreach dir, $(SRC_DIRS), $(notdir $(dir)))
OBJS := $(foreach n, $(NAMES), $(OBJ_DIR)/$(n).o)
LIBS := $(foreach n, $(NAMES), $(LIB_DIR)/$(n).so)
HEDS := $(foreach n, $(NAMES), $(INC_DIR)/$(n).h)

OBJ_TARGET := obj
LIB_TARGET := lib
CLEAN_TARGET := clean

TARGET := $(LIB_DIR)/libstructures.so

LDFLAGS := 

all: $(DIRS) $(LIBS) $(HEDS) $(TARGET)
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $<

$(OBJ_DIR)/%.o: %
	$(MAKE) $(OBJ_TARGET) -C $(STRUCT_DIR)/$<
	cp $(STRUCT_DIR)/$</$<.o $@

$(LIB_DIR)/%.so: %
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
	$(foreach n, $(NAMES), $(MAKE) $(CLEAN_TARGET) -C $(STRUCT_DIR)/$(n))

cleanall:
	rm -rf $(DIRS)

.PHONY: all