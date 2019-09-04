

MODULES	:=	module

define compile_module
	@rm -fr $(CURDIR)/application/romfs/lib$(1).nro
	@$(MAKE) -C $(1)/
	@mkdir -p $(CURDIR)/application/romfs
	@cp $(CURDIR)/$(1)/lib$(1).nro $(CURDIR)/application/romfs/lib$(1).nro
endef

define clean_module
	@$(MAKE) clean -C $(1)/
endef

.PHONY: all clean

all:
	@$(foreach mod, $(MODULES), $(call compile_module,$(mod)))
	@$(MAKE) -C application/

clean:
	@$(foreach mod, $(MODULES), $(call clean_module,$(mod)))
	@$(MAKE) clean -C application/
