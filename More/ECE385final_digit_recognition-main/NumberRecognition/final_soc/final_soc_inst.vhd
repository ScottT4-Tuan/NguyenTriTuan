	component final_soc is
		port (
			clk_clk          : in    std_logic                     := 'X';             -- clk
			reset_reset_n    : in    std_logic                     := 'X';             -- reset_n
			sdram_clk_clk    : out   std_logic;                                        -- clk
			sdram_wire_addr  : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba    : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n : out   std_logic;                                        -- cas_n
			sdram_wire_cke   : out   std_logic;                                        -- cke
			sdram_wire_cs_n  : out   std_logic;                                        -- cs_n
			sdram_wire_dq    : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm   : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_wire_ras_n : out   std_logic;                                        -- ras_n
			sdram_wire_we_n  : out   std_logic;                                        -- we_n
			res_0_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_1_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_2_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_3_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_4_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_5_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_6_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_7_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_8_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			res_9_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			inference_export : out   std_logic_vector(3 downto 0)                      -- export
		);
	end component final_soc;

	u0 : component final_soc
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --        clk.clk
			reset_reset_n    => CONNECTED_TO_reset_reset_n,    --      reset.reset_n
			sdram_clk_clk    => CONNECTED_TO_sdram_clk_clk,    --  sdram_clk.clk
			sdram_wire_addr  => CONNECTED_TO_sdram_wire_addr,  -- sdram_wire.addr
			sdram_wire_ba    => CONNECTED_TO_sdram_wire_ba,    --           .ba
			sdram_wire_cas_n => CONNECTED_TO_sdram_wire_cas_n, --           .cas_n
			sdram_wire_cke   => CONNECTED_TO_sdram_wire_cke,   --           .cke
			sdram_wire_cs_n  => CONNECTED_TO_sdram_wire_cs_n,  --           .cs_n
			sdram_wire_dq    => CONNECTED_TO_sdram_wire_dq,    --           .dq
			sdram_wire_dqm   => CONNECTED_TO_sdram_wire_dqm,   --           .dqm
			sdram_wire_ras_n => CONNECTED_TO_sdram_wire_ras_n, --           .ras_n
			sdram_wire_we_n  => CONNECTED_TO_sdram_wire_we_n,  --           .we_n
			res_0_export     => CONNECTED_TO_res_0_export,     --      res_0.export
			res_1_export     => CONNECTED_TO_res_1_export,     --      res_1.export
			res_2_export     => CONNECTED_TO_res_2_export,     --      res_2.export
			res_3_export     => CONNECTED_TO_res_3_export,     --      res_3.export
			res_4_export     => CONNECTED_TO_res_4_export,     --      res_4.export
			res_5_export     => CONNECTED_TO_res_5_export,     --      res_5.export
			res_6_export     => CONNECTED_TO_res_6_export,     --      res_6.export
			res_7_export     => CONNECTED_TO_res_7_export,     --      res_7.export
			res_8_export     => CONNECTED_TO_res_8_export,     --      res_8.export
			res_9_export     => CONNECTED_TO_res_9_export,     --      res_9.export
			inference_export => CONNECTED_TO_inference_export  --  inference.export
		);

