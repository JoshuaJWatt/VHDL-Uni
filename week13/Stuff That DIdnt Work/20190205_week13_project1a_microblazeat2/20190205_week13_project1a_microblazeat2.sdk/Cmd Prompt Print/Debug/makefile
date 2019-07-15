################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
Cmd\ Prompt\ Print.elf.size \


# All Target
all: Cmd\ Prompt\ Print.elf secondary-outputs

# Tool invocations
Cmd\ Prompt\ Print.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze gcc linker'
	mb-gcc -Wl,-T -Wl,../src/lscript.ld -L../../Cmd Prompt Print_bsp/microblaze_0/lib -mlittle-endian -mcpu=v9.5 -mxl-soft-mul -o "Cmd Prompt Print.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

Cmd\ Prompt\ Print.elf.size: Cmd\ Prompt\ Print.elf
	@echo 'Invoking: MicroBlaze Print Size'
	mb-size Cmd Prompt Print.elf  |tee "Cmd Prompt Print.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(S_UPPER_DEPS)$(C_DEPS)$(ELFSIZE) "Cmd Prompt Print.elf"
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
