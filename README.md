# wormholeRouter
RTL NoC Router with Wormhole Flow Control

To run the 4x4 Mesh Router to gather throughput results:
	 1. Specify the Injection Rate, Number of Simulation Cycles, and Buffer Depth in Mesh_tb.sv
		1a. variables inj_rate, num_cycles, and buffer_depth are in lines 16-18 of mesh_tb.sv
		1b. inj_rate is a percentage from 0 to 100. Default it is at 50%.
	 2. compile all modules in the src folder
	 3. Simulate mesh_tb.sv
		2a. "vsim -novopt work.mesh_tb"
		2b. run -a
	 4. Wallah ! the score is how many flits were recovered.
