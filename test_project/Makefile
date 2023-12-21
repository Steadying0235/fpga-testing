BOARD=tangprimer20k
FAMILY=GW2A-18
DEVICE=GW2A-LV18PG256C8/I7
SRC_DIR=src/

all: led.fs

# Synthesis
led.json: ${SRC_DIR}led.v
	yosys -p "read_verilog ${SRC_DIR}led.v; synth_gowin -top led -json led.json"

# Place and Route
led_pnr.json: led.json
	nextpnr-gowin --json led.json --freq 27 --write led_pnr.json --device ${DEVICE} --family ${FAMILY} --cst ${SRC_DIR}test_project.cst

# Generate Bitstream
led.fs: led_pnr.json
	gowin_pack -d ${FAMILY} -o led.fs led_pnr.json

# Program Board
load: led.fs
	openFPGALoader -b ${BOARD} led.fs -f

.PHONY: load
.INTERMEDIATE: led_pnr.json led.json

