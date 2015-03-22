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
add wave -noupdate -color {Medium Slate Blue} -radix unsigned -childformat {{{/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[5]} -radix unsigned} {{/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[4]} -radix unsigned} {{/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[3]} -radix unsigned} {{/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[2]} -radix unsigned} {{/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[1]} -radix unsigned} {{/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[0]} -radix unsigned}} -subitemconfig {{/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[5]} {-color {Medium Slate Blue} -height 15 -radix unsigned} {/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[4]} {-color {Medium Slate Blue} -height 15 -radix unsigned} {/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[3]} {-color {Medium Slate Blue} -height 15 -radix unsigned} {/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[2]} {-color {Medium Slate Blue} -height 15 -radix unsigned} {/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[1]} {-color {Medium Slate Blue} -height 15 -radix unsigned} {/tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op[0]} {-color {Medium Slate Blue} -height 15 -radix unsigned}} /tb_MC_TOP/U0_MC_TOP/U5_FSM/i_op
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
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U6_MUX2_1_5bits/i_data1
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U6_MUX2_1_5bits/i_data2
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U6_MUX2_1_5bits/sel
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U6_MUX2_1_5bits/o_data
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U7_MUX2_1/i_data1
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U7_MUX2_1/i_data2
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U7_MUX2_1/sel
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U7_MUX2_1/o_data
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
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U9_A/i_clk
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U9_A/i_x
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U9_A/o_y
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U10_B/i_clk
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U10_B/i_x
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U10_B/o_y
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U11_MUX2_1/i_data1
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U11_MUX2_1/i_data2
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U11_MUX2_1/sel
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U11_MUX2_1/o_data
add wave -noupdate -color Magenta -radix unsigned /tb_MC_TOP/U0_MC_TOP/U12_SEU/i_halfword
add wave -noupdate -color Magenta -radix unsigned /tb_MC_TOP/U0_MC_TOP/U12_SEU/o_word
add wave -noupdate -color Magenta -radix unsigned /tb_MC_TOP/U0_MC_TOP/U12_SEU/sign
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/i_data1
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/i_data2
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/i_data3
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/i_data4
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/sel
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/o_data
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/w_data1
add wave -noupdate -color Orange -radix unsigned /tb_MC_TOP/U0_MC_TOP/U13_MUX4_1/w_data2
add wave -noupdate -color Tan -radix unsigned /tb_MC_TOP/U0_MC_TOP/U14_ALUControl/funct
add wave -noupdate -color Tan -radix unsigned /tb_MC_TOP/U0_MC_TOP/U14_ALUControl/ALUOp
add wave -noupdate -color Tan -radix unsigned /tb_MC_TOP/U0_MC_TOP/U14_ALUControl/ALU_control_signal
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data1
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/i_data2
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/ALUop
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/o_result
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/o_zero
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_and
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_or
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_add
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_sub
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_slt
add wave -noupdate -color Thistle -radix unsigned /tb_MC_TOP/U0_MC_TOP/U15_ALU/w_nor
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U16_ALUOut/i_clk
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U16_ALUOut/i_alu_result
add wave -noupdate -radix unsigned /tb_MC_TOP/U0_MC_TOP/U16_ALUOut/o_alu_out
add wave -noupdate -color {Yellow Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U17_MUX3_1/i_data1
add wave -noupdate -color {Yellow Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U17_MUX3_1/i_data2
add wave -noupdate -color {Yellow Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U17_MUX3_1/i_data3
add wave -noupdate -color {Yellow Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U17_MUX3_1/sel
add wave -noupdate -color {Yellow Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U17_MUX3_1/o_data
add wave -noupdate -color {Yellow Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U17_MUX3_1/w_data1
add wave -noupdate -color {Yellow Green} -radix unsigned /tb_MC_TOP/U0_MC_TOP/U17_MUX3_1/w_data2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {172300 ps} 0}
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
