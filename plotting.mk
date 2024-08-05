gp_cycle=source gptools/tools.sh; pdf_with_labels $(1); mv $(1).tex $(2); mv $(1).pdf $(2); mv $(1)_labels.pdf $(2)
gp_cycle_filenames=$(1).tex $(1).pdf $(1)_labels.pdf

exdir=experiments/$(1)
pldir=data/plots/$(1)
gpdir=$(1)
tbdir=data/tables/$(1)

# Generates a rule for creating the directory data/plots/$(1) (where the plots are stored)
define pltdir
$(call pldir,$(1)):
	mkdir -p $(call pldir,$(1))
endef

# Targets for generating plots
# $(1): name of the plot dir (typically the name of the experiment)
# #(2): name of the gnuplot script
# $(3): name of the plot (must be output of the gnuplot script without extension)
# $(4): name of the data file
# $(5): (optional) additional gnuplot arguments
# $(6): (optional) additional dependencies
define plt
$(call gp_cycle_filenames,$(call pldir,$(1))/$(3)): $(call gpdir,$(1))/$(2) $(call tbdir,$(1))/$(4) $(6) | $(call pldir,$(1))
	-module load gnuplot/6.0.0
	gnuplot -e "$(5)" $(call gpdir,$(1))/$(2)
	$(call gp_cycle, $(3), $(call pldir,$(1)))
endef
