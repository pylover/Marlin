
PLATFORM = arduino:avr
FQBN = $(PLATFORM):mega
SKETCH = Marlin
FLAGS = -v

.PHONY: sketch
sketch:
	arduino-cli $(FLAGS) compile --fqbn $(FQBN) $(SKETCH)

.PHONY: program
program:
	arduino-cli $(FLAGS) upload -p /dev/ttyACM0 --fqbn $(FQBN) $(SKETCH)

.PHONY: env
env:
	arduino-cli core update-index
	arduino-cli core core install arduino:avr

.PHONY: clean
clean:
	arduino-cli cache clean
