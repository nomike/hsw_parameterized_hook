# Parametric OpenSCAD design file
OPENSCAD_FILE = hsw_parametric_hook.scad

# JSON file containing parameter sets
PARAMETER_SETS_FILE = hsw_parametric_hook.json

# Output directory for generated STL files
OUTPUT_DIR = output

# Function to extract parameter set names from the JSON file
get_parameter_set_names = $(shell jq -r '.parameterSets | keys[]' $(PARAMETER_SETS_FILE))

# Function to construct the STL filename for a given parameter set
stl_filename = $(OUTPUT_DIR)/$(basename $(OPENSCAD_FILE))-$(1).stl

.PHONY: all clean

all: $(OUTPUT_DIR) $(foreach set,$(call get_parameter_set_names),$(call stl_filename,$(set)))

$(OUTPUT_DIR):
	mkdir -p $@

$(call stl_filename,%): $(OPENSCAD_FILE) $(PARAMETER_SETS_FILE)
	openscad -o $@ $(OPENSCAD_FILE) -p $(PARAMETER_SETS_FILE) -P '$(subst .stl,,$(subst $(subst .scad,,$(OPENSCAD_FILE))-,,$(@F)))'

clean:
	rm -f $(OUTPUT_DIR)/*.stl
