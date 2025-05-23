module SCCB_interface
#(
    parameter CLK_FREQ = 25000000,
    parameter SCCB_FREQ = 100000
)
(
    input logic clk,
    input logic start,
    input logic [7:0] address,
    input logic [7:0] data,
    output logic ready,
    output logic SIOC_oe,
    output logic SIOD_oe
    );
    
    localparam CAMERA_ADDR = 8'h42;
    localparam FSM_IDLE = 0;
    localparam FSM_START_SIGNAL = 1;
    localparam FSM_LOAD_BYTE = 2;
    localparam FSM_TX_BYTE_1 = 3;
    localparam FSM_TX_BYTE_2 = 4;
    localparam FSM_TX_BYTE_3 = 5;
    localparam FSM_TX_BYTE_4 = 6;
    localparam FSM_END_SIGNAL_1 = 7;
    localparam FSM_END_SIGNAL_2 = 8;
    localparam FSM_END_SIGNAL_3 = 9;
    localparam FSM_END_SIGNAL_4 = 10;
    localparam FSM_DONE = 11;
    localparam FSM_TIMER = 12;
    
    
//    initial begin 
//        SIOC_oe = 0;
//        SIOD_oe = 0;
//        ready = 1;
//    end
    
    logic [3:0] FSM_state = 0;
    logic [3:0] FSM_return_state = 0;
    logic [31:0] timer = 0;
    logic [7:0] latched_address;
    logic [7:0] latched_data; 
    logic [1:0] byte_counter = 0;
    logic [7:0] tx_byte = 0;
    logic [3:0] byte_index = 0;
    
    
    always_ff@(posedge clk) begin
        
        case(FSM_state) 
        
            FSM_IDLE: begin
                byte_index <= 0;
                byte_counter <= 0;
                if (start) begin 
                    FSM_state <= FSM_START_SIGNAL;
                    latched_address <= address;
                    latched_data <= data;
                    ready <= 0;
                end
                else begin
                    ready <= 1;
                end
            end
            
            FSM_START_SIGNAL: begin //comunication interface start signal, bring SIOD low
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_LOAD_BYTE;
                timer <= (CLK_FREQ/(4*SCCB_FREQ));
                SIOC_oe <= 0;
                SIOD_oe <= 1;
            end
            
            FSM_LOAD_BYTE: begin //load next byte to be transmitted
                FSM_state <= (byte_counter == 3) ? FSM_END_SIGNAL_1 : FSM_TX_BYTE_1;
                byte_counter <= byte_counter + 1;
                byte_index <= 0; //clear byte index
                case(byte_counter)
                    0: tx_byte <= CAMERA_ADDR;
                    1: tx_byte <= latched_address;
                    2: tx_byte <= latched_data;
                    default: tx_byte <= latched_data;
                endcase
            end
            
            FSM_TX_BYTE_1: begin //bring SIOC low and and delay for next state 
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_TX_BYTE_2;
                timer <= (CLK_FREQ/(4*SCCB_FREQ));
                SIOC_oe <= 1; 
            end
            
            FSM_TX_BYTE_2: begin //assign output data, 
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_TX_BYTE_3;
                timer <= (CLK_FREQ/(4*SCCB_FREQ)); //delay for SIOD to stabilize
                SIOD_oe <= (byte_index == 8) ? 0 : ~tx_byte[7]; //allow for 9 cycle ack, output enable signal is inverting
            end
            
            FSM_TX_BYTE_3: begin // bring SIOC high 
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_TX_BYTE_4;
                timer <= (CLK_FREQ/(2*SCCB_FREQ));
                SIOC_oe <= 0; //output enable is an inverting pulldown
            end
            
            FSM_TX_BYTE_4: begin //check for end of byte, incriment counter
                FSM_state <= (byte_index == 8) ? FSM_LOAD_BYTE : FSM_TX_BYTE_1;
                tx_byte <= tx_byte<<1; //shift in next data bit
                byte_index <= byte_index + 1;
            end
            
            FSM_END_SIGNAL_1: begin //state is entered with SIOC high, SIOD high. Start by bringing SIOC low
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_END_SIGNAL_2;
                timer <= (CLK_FREQ/(4*SCCB_FREQ));
                SIOC_oe <= 1;
            end
            
            FSM_END_SIGNAL_2: begin // while SIOC is low, bring SIOD low 
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_END_SIGNAL_3;
                timer <= (CLK_FREQ/(4*SCCB_FREQ));
                SIOD_oe <= 1;
            end
            
            FSM_END_SIGNAL_3: begin // bring SIOC high
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_END_SIGNAL_4;
                timer <= (CLK_FREQ/(4*SCCB_FREQ));
                SIOC_oe <= 0;
            end
            
            FSM_END_SIGNAL_4: begin // bring SIOD high when SIOC is high
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_DONE;
                timer <= (CLK_FREQ/(4*SCCB_FREQ));
                SIOD_oe <= 0;
            end
            
            FSM_DONE: begin //add delay between transactions
                FSM_state <= FSM_TIMER;
                FSM_return_state <= FSM_IDLE;
                timer <= (2*CLK_FREQ/(SCCB_FREQ));
                byte_counter <= 0;
            end
            
            FSM_TIMER: begin //count down and jump to next state
                FSM_state <= (timer == 0) ? FSM_return_state : FSM_TIMER;
                timer <= (timer==0) ? 0 : timer - 1;
            end
        endcase
    end
    
    
endmodule
