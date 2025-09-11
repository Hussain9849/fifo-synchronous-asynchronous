`include "sync_fifo.v"
module tb;
     parameter WIDTH = 8;
     parameter FIFO_SIZE = 16;
     parameter PTR_WIDTH = $clog2(FIFO_SIZE);
     reg res,clk,wr_en,rd_en;
     reg [WIDTH-1:0]wdata;
     wire full,empty,overflow,underflow;
     wire[WIDTH-1:0]rdata;
     integer i,j,k,l;
     reg [15*8-1:0]test_name;
     sync_fifo dut(.res(res),.clk(clk),.wr_en(wr_en),.wdata(wdata),.full(full),
	 .overflow(overflow),.rd_en(rd_en),.rdata(rdata),.empty(empty),.underflow(underflow));
	 integer wr_delay,rd_delay;
	 always #5 clk = ~clk; 
	 initial begin
	   if($value$plusargs("test_name=%s",test_name));
	 end
	 initial begin
	   clk = 0;
	   res  =1;
	   rd_en = 0;
	   wr_en = 0;
	   wdata = 0;
	   repeat(2)@(posedge clk);
	   res = 0;
	  // if($value$plusargs("test name=%0s",test_name));
	   case(test_name)
         "full_and_empty":begin
	          writes(FIFO_SIZE);
			  reads(FIFO_SIZE);
	      end
		  "reads":begin
		      writes(FIFO_SIZE);
		      reads(FIFO_SIZE);
		  end
		  "overflow":begin
		     writes(FIFO_SIZE+1);
			 //reads(FIFO_SIZE+1);
			 end
		  "underflow":begin
		     writes(FIFO_SIZE);
			 reads(FIFO_SIZE+1);
			end
		  "consecutive":begin
		     consecutive(FIFO_SIZE);  
			end
		  default:$display("nothing is happen");
	   endcase
	  // writes(FIFO_SIZE);
	   #100;
	   $finish;
	  end
	  task writes(input integer no_writes);begin 
	     for(i=0;i<no_writes;i=i+1)begin
		    @(posedge clk);
			wr_en = 1;
	        wdata = $random;
	   end
	       @(posedge clk);
	        wr_en = 0;
			wdata = 0;
	   end
	   endtask
	  task reads(input integer no_reads);begin
	     for(j=0;j<no_reads;j=j+1)begin
	        @(posedge clk);
	        rd_en = 1;
         end
	        @(posedge clk);
	        rd_en = 0;
	  end
	  endtask
   //using fork join
	   task consecutive(input integer no_writes_and_reads);begin
	     fork
		   begin
		     for(k=0;k<20;k=k+1)begin
			    writes(1);
				wr_delay = $urandom_range(5,10);
				#(wr_delay);
			 end
	        end
			begin
			  wait(empty==0);
			  for(l=0;l<20;l=l+1)begin
			    reads(1);
				rd_delay = $urandom_range(5,10);
			    #(rd_delay);
			 end
			end
	    	join
	  end
	  endtask

  
    // we can use for loop also
	//  task consecutive(input integer no_writes_and_reads);begin
	//     for(k=0;k<no_writes_and_reads;k=k+1)begin
	//	    @(posedge clk);
	//		wr_en = 1;
	//		wdata = $random;
	//		@(posedge clk);
    //        wr_en = 0;
	//		wdata = 0;
	//		rd_en = 0;

    //        @(posedge clk);
	//		rd_en = 1;
	//		@(posedge clk);
    //        wr_en = 0;
	//		wdata = 0;
	//		rd_en = 0;
	//	 end
	//	 end
	//  endtask
endmodule
