// 
//  Author: Umang Garg (umanggarg96@gmail.com)
//                         

module tb_alu;
    parameter WIDHT = 16;

    logic [WIDHT-1:0] x;
    logic [WIDHT-1:0] y;
    logic             zx;
    logic             nx;
    logic             zy;
    logic             ny;
    logic             f;
    logic             no;

    logic [WIDHT-1:0] out;
    logic             zr;
    logic             ng;

    alu #(.WIDHT(WIDHT))  dut ( .* );


    function void initialize();
        x   =  0;
        y   =  0;
        zx  =  0;
        nx  =  0;
        zy  =  0;
        ny  =  0;
        f   =  0;
        no  =  0;
    endfunction

    function void randomize_inputs();
        x   =  $random();
        y   =  $random();
        zx  =  $urandom();
        nx  =  $urandom();
        zy  =  $urandom();
        ny  =  $urandom();
        f   =  $urandom();
        no  =  $urandom();
    endfunction

    initial begin
        initialize();
        repeat(10000) begin
            #10
            randomize_inputs();
        end
    end

    // checker
    bit signed [WIDHT-1:0] a,b,c;
    initial begin
        forever begin
            @(x, y, zx, nx, zy, ny, f, no, out, zr, ng);
            #1;
            a = x;
            a = zx ? '0 : a;
            a = nx ? ~a : a;

            b = y;
            b = zy ? '0 : b;
            b = ny ? ~b : b;

            c = f ? (a + b) : (a & b);

            c = no ? ~c : c;

            if (out != c) begin
                $display($time, " INFO : x = %h, y = %h, zx = %b, nx = %b, zy = %b, ny = %b, f = %b, no = %b, out = %h, zr = %b, ng = %b", x, y, zx, nx, zy, ny, f, no, out, zr, ng);
                $display($time, " ERROR: out mismatch. Exp = %h, is = %h", c, out);
            end

            if (zr != (c == 0)) begin
                $display($time, " INFO : x = %h, y = %h, zx = %b, nx = %b, zy = %b, ny = %b, f = %b, no = %b, out = %h, zr = %b, ng = %b", x, y, zx, nx, zy, ny, f, no, out, zr, ng);
                $display($time, " ERROR: zr mismatch. Exp = %h, is = %h", (c == 0), zr);
            end

            if (ng != (c < 0)) begin
                $display($time, " INFO : x = %h, y = %h, zx = %b, nx = %b, zy = %b, ny = %b, f = %b, no = %b, out = %h, zr = %b, ng = %b", x, y, zx, nx, zy, ny, f, no, out, zr, ng);
                $display($time, " ERROR: ng mismatch. Exp = %h, is = %h", (c < 0), ng);
            end
        end
    end


endmodule
