
TOP_FILE := bubbleSort.c
COMPONENT_FILES :=  
HEADER_FILES := bubbleSort.h

# name of compiled file
TOP_MODULE	     := $(notdir $(basename $(TOP_FILE)))



# Directries where the source and compiled code is located
SRC  := source
COMP := compiled

GCC_FLAGS :=


# Build Targets
all: $(COMP)/$(TOP_MODULE)


# taget for compiled c file
$(COMP)/$(TOP_MODULE): $(addprefix $(SRC)/, $(TOP_FILE) $(COMPONENT_FILES))
	@echo "Building the top file..."
	@mkdir -p $(COMP)
	@gcc -o $@ $^
	@echo "Done."


run: $(COMP)/$(TOP_MODULE) 
	@echo "Running the top file..."
	@./$^
	@echo "Done."



clean: 
	rm -rf $(COMP)/

###########################################################################################
# Designate targets that do not correspond directly to files so that they are
# run every time they are called
###########################################################################################
.PHONY: all clean run
