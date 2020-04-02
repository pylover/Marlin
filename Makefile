
PLATFORM = arduino:avr
FQBN = $(PLATFORM):mega
SKETCH = Marlin
FLAGS = -v

sketch:
	arduino-cli $(FLAGS) compile --fqbn $(FQBN) $(SKETCH)

program:
	arduino-cli $(FLAGS) upload -p /dev/ttyACM0 --fqbn $(FQBN) $(SKETCH)

env:
	arduino-cli core update-index
	arduino-cli core core install arduino:avr

