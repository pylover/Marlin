
PLATFORM = arduino:avr
FQBN = $(PLATFORM):mega
SKETCH = Marlin
FLAGS = -v
CC = arduino-cli
PORT = /dev/ttyACM0
HOST = pinky


.PHONY: sketch
sketch:
	$(CC) $(FLAGS) compile --fqbn $(FQBN) $(SKETCH)


.PHONY: program
program:
	$(CC) $(FLAGS) upload -p $(PORT) --fqbn $(FQBN) $(SKETCH)


.PHONY: fota
fota:
	ssh root@$(HOST) "service serialhub stop"
	ssh $(HOST) "mkdir -p $(SKETCH)"
	scp -r $(SKETCH)/build $(HOST):Marlin
	ssh $(HOST) "$(CC) $(FLAGS) upload -p $(PORT) --fqbn $(FQBN) $(SKETCH)"
	ssh root@$(HOST) "service serialhub start"


.PHONY: env
env:
	$(CC) config init
	$(CC) core update-index
	$(CC) core install arduino:avr
	$(CC) lib update-index
	$(CC) lib install U8glib


.PHONY: clean
clean:
	arduino-cli cache clean

