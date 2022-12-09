// 
//  Author: Umang Garg (umanggarg96@gmail.com)
//                         
//                                    ------------------------
//                            16-bit  |                      | 16-bit
//                          x ------> |                      | ------> out
//                                    |                      | 
//                            16-bit  |                      | 1-bit
//                          y ------> |         ALU          | ------> zr
//                                    |                      | 
//                            6-bit   |                      | 1-bit
//         {zr,nx,zy,ny,f,no} ------> |                      | ------> ng
//                                    |                      |
//                                    ------------------------
//
//          Stage-1:
//              zx -> set x to zero
//              zy -> set y to zero
//
//          Stage-2:
//              nx -> bitwise not of x
//              ny -> bitwise not of y
//
//          Stage-3:
//              f  -> for f == 1 => x + y, otherwise => x & y
//
//          Stage-4:
//              ny -> bitwise not of out
//
//              zr -> is out zero?
//              ng -> is out negative?
//

module alu # (
    parameter WIDHT = 16
)
(
    input  wire [WIDHT-1:0] x,
    input  wire [WIDHT-1:0] y,
    input  wire             zx,
    input  wire             nx,
    input  wire             zy,
    input  wire             ny,
    input  wire             f,
    input  wire             no,

    output wire [WIDHT-1:0] out,
    output wire             zr,
    output wire             ng
);

    // Stage-1 outputs
    wire [WIDHT-1:0] s1_x, s1_y;

    assign s1_x = zx ? '0 : x;
    assign s1_y = zy ? '0 : y;

    // Stage-2 outputs
    wire [WIDHT-1:0] s2_x, s2_y;

    assign s2_x = nx ?  ~s1_x : s1_x;
    assign s2_y = ny ?  ~s1_y : s1_y;

    // Stage-3 outputs
    wire [WIDHT-1:0] s3_out;

    assign s3_out = f ? (s2_x + s2_y) :  (s2_x & s2_y);

    // Stage-4 outputs
    
    assign out = no ? ~s3_out : s3_out;
    assign zr  = (out == '0);
    assign ng  = (out[WIDHT-1] == 1'b1);

endmodule
