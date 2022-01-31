	component niosII is
		port (
			clk_clk               : in  std_logic := 'X'; -- clk
			reset_reset_n         : in  std_logic := 'X'; -- reset_n
			generator_export_fout : out std_logic         -- fout
		);
	end component niosII;

	u0 : component niosII
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --              clk.clk
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --            reset.reset_n
			generator_export_fout => CONNECTED_TO_generator_export_fout  -- generator_export.fout
		);

