// Mysha Rahman
// 1330012042


`timescale 10 ns/ 1 ps
`define DELAY 1

module tb_traffic;
parameter ENDTIME  = 400000;
reg clk;
reg rst_n;
reg sensor;
wire [2:0] light_farm;
wire [2:0] light_highway;

traffic_light tb(light_highway, light_farm, sensor, clk, rst_n);

initial
 begin
 clk = 1'b0;
 rst_n = 1'b0;
 sensor = 1'b0;
 end
 
initial
 begin
 main;
 end
 
task main;
 fork
 clock_gen;
 reset_gen;
 operation_flow;
 debug_output;
 endsimulation;
 join
endtask
task clock_gen;
 begin
 forever #`DELAY clk = !clk;
 end
endtask

task reset_gen;
 begin
 rst_n = 0;
 # 20
 rst_n = 1;
 end
endtask


task operation_flow;
 begin
 sensor = 0;
 # 600
 sensor = 1;
 # 1200
 sensor = 0;
 # 1200
 sensor = 1;
 end
endtask

task debug_output;
 begin
 $display("----------------------------------------------");
        $display("------------------     -----------------------");
 $display("----------- Traffic Control ----------------");
 $display("--------------             -------------------");
 $display("----------------         ---------------------");
 $display("----------------------------------------------");
 $monitor("TIME = %d, reset = %b, sensor = %b, light of highway = %h, light of farm road = %h",$time,rst_n ,sensor,light_highway,light_farm );
 end
endtask

task endsimulation;
 begin
 #ENDTIME
 $display("-------------- TASK END ------------");
 $finish;
 end
endtask
    
endmodule