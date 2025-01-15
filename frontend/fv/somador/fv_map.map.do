
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point carry_i carry_i -type PI PI
add mapped point a_i[7] a_i[7] -type PI PI
add mapped point a_i[6] a_i[6] -type PI PI
add mapped point a_i[5] a_i[5] -type PI PI
add mapped point a_i[4] a_i[4] -type PI PI
add mapped point a_i[3] a_i[3] -type PI PI
add mapped point a_i[2] a_i[2] -type PI PI
add mapped point a_i[1] a_i[1] -type PI PI
add mapped point a_i[0] a_i[0] -type PI PI
add mapped point b_i[7] b_i[7] -type PI PI
add mapped point b_i[6] b_i[6] -type PI PI
add mapped point b_i[5] b_i[5] -type PI PI
add mapped point b_i[4] b_i[4] -type PI PI
add mapped point b_i[3] b_i[3] -type PI PI
add mapped point b_i[2] b_i[2] -type PI PI
add mapped point b_i[1] b_i[1] -type PI PI
add mapped point b_i[0] b_i[0] -type PI PI

//output ports
add mapped point carry_o carry_o -type PO PO
add mapped point sum_o[7] sum_o[7] -type PO PO
add mapped point sum_o[6] sum_o[6] -type PO PO
add mapped point sum_o[5] sum_o[5] -type PO PO
add mapped point sum_o[4] sum_o[4] -type PO PO
add mapped point sum_o[3] sum_o[3] -type PO PO
add mapped point sum_o[2] sum_o[2] -type PO PO
add mapped point sum_o[1] sum_o[1] -type PO PO
add mapped point sum_o[0] sum_o[0] -type PO PO

//inout ports




//Sequential Pins
add mapped point sum_temp[8]/q sum_temp_reg[8]/Q  -type DFF DFF
add mapped point sum_temp[7]/q sum_temp_reg[7]/Q  -type DFF DFF
add mapped point sum_temp[6]/q sum_temp_reg[6]/Q  -type DFF DFF
add mapped point sum_temp[5]/q sum_temp_reg[5]/Q  -type DFF DFF
add mapped point sum_temp[4]/q sum_temp_reg[4]/Q  -type DFF DFF
add mapped point sum_temp[3]/q sum_temp_reg[3]/Q  -type DFF DFF
add mapped point sum_temp[2]/q sum_temp_reg[2]/Q  -type DFF DFF
add mapped point sum_temp[1]/q sum_temp_reg[1]/Q  -type DFF DFF
add mapped point sum_temp[0]/q sum_temp_reg[0]/Q  -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
