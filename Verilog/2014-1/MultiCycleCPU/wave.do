onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Yellow -radix unsigned /tb_MC_TOP/U0_MC_TOP/U0_PC/i_next_pc
add wave -noupdate -color Yellow -radix unsigned /tb_MC_TOP/U0_MC_TOP/U0_PC/i_pc_w_c
add wave -noupdate -color Yellow -radix unsigned /tb_MC_TOP/U0_MC_TOP/U0_PC/i_rst_n
add wave -noupdate -color Yellow -radix unsigned /tb_MC_TOP/U0_MC_TOP/U0_PC/i_clk
add wave -noupdate -color Yellow -radix unsigned /tb_MC_TOP/U0_MC_TOP/U0_PC/o_pc
add wave -noupdate -color {Medium Sea Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U1_MUX2_1/i_data1
add wave -noupdate -color {Medium Sea Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U1_MUX2_1/i_data2
add wave -noupdate -color {Medium Sea Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U1_MUX2_1/sel
add wave -noupdate -color {Medium Sea Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U1_MUX2_1/o_data
add wave -noupdate -color {Olive Drab} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/i_clk
add wave -noupdate -color {Olive Drab} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/i_rst_n
add wave -noupdate -color {Olive Drab} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/MemRead
add wave -noupdate -color {Olive Drab} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/MemWrite
add wave -noupdate -color {Olive Drab} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/i_addr
add wave -noupdate -color {Olive Drab} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/i_WriteData
add wave -noupdate -color {Olive Drab} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/o_MemData
add wave -noupdate -radix binary /tb_MC_TOP/U0_MC_TOP/U2_MEMORY/mem
add wave -noupdate -color {Cadet Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U3_MDR/i_clk
add wave -noupdate -color {Cadet Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U3_MDR/i_data
add wave -noupdate -color {Cadet Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U3_MDR/o_data
add wave -noupdate -color Aquamarine -radix unsigned /tb_MC_TOP/U0_MC_TOP/U4_IR/i_clk
add wave -noupdate -color Aquamarine -radix unsigned /tb_MC_TOP/U0_MC_TOP/U4_IR/IRWrite
add wave -noupdate -color Aquamarine -radix unsigned /tb_MC_TOP/U0_MC_TOP/U4_IR/i_Instr
add wave -noupdate -color Aquamarine -radix unsigned /tb_MC_TOP/U0_MC_TOP/U4_IR/o_op
add wave -noupdate -color Aquamarine -radix unsigned /tb_MC_TOP/U0_MC_TOP/U4_IR/o_rs
add wave -noupdate -color Aquamarine -radix unsigned /tb_MC_TOP/U0_MC_TOP/U4_IR/o_rt
add wave -noupdate -color Aquamarine -radix unsigned /tb_MC_TOP/U0_MC_TOP/U4_IR/o_Imm16
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/i_clk
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/i_rst_n
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/PCWriteCond
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/PCWrite
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/IorD
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/MemRead
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/MemWrite
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/MemtoReg
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/IRWrite
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/ALUSrcA
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/RegWrite
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/RegDst
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/PCSource
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/ALUOp
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/ALUSrcB
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/cur_state
add wave -noupdate -color {Medium Slate Blue} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U5_FSM/next_state
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/RegWrite
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/i_rst_n
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/i_clk
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/i_Write_reg
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/i_Read_reg1
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/i_Read_reg2
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/i_Write_data
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/o_Read_data1
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/o_Read_data2
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_dec0
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_dec1
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg0
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg1
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg2
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg3
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg4
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg5
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg6
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg7
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg8
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg9
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg10
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg11
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg12
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg13
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg14
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg15
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg16
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg17
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg18
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg19
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg20
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg21
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg22
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg23
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg24
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg25
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg26
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg27
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg28
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg29
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg30
add wave -noupdate -color {Dark Orchid} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U8_RF/w_reg31
add wave -noupdate -color Magenta -radix unsigned /tb_MC_TOP/U0_MC_TOP/U12_SEU/i_halfword
add wave -noupdate -color Magenta -radix unsigned /tb_MC_TOP/U0_MC_TOP/U12_SEU/o_word
add wave -noupdate -color Magenta -radix unsigned /tb_MC_TOP/U0_MC_TOP/U12_SEU/sign
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data1
add wave -noupdate -color Thistle -radix unsigned -subitemconfig {{/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[31]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[30]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[29]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[28]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[27]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[26]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[25]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[24]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[23]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[22]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[21]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[20]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[19]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[18]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[17]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[16]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[15]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[14]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[13]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[12]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[11]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[10]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[9]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[8]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[7]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[6]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[5]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[4]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[3]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[2]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[1]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2[0]} {-color Thistle -height 15}} /tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2
add wave -noupdate -color Thistle -radix unsigned -subitemconfig {{/tb_MC_TOP/U0_MC_TOP/U15_ALU/ALUop[3]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/ALUop[2]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/ALUop[1]} {-color Thistle -height 15} {/tb_MC_TOP/U0_MC_TOP/U15_ALU/ALUop[0]} {-color Thistle -height 15}} /tb_MC_TOP/U0_MC_TOP/U15_ALU/ALUop
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/o_result
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/o_zero
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_and
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_or
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_add
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_sub
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_slt
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_nor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29900 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 324
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {907200 ps}
