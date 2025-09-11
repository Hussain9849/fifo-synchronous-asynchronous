module sync_fifo(res,clk,wr_en,wdata,full,overflow,rd_en,rdata,empty,underflow);
   parameter WIDTH = 8;
   parameter FIFO_SIZE = 16;
   parameter PTR_WIDTH = $clog2(FIFO_SIZE);
   input res,clk,wr_en,rd_en;
   input [WIDTH-1:0]wdata;
   output reg full,empty,overflow,underflow;
   output reg[WIDTH-1:0]rdata;
   reg [PTR_WIDTH-1:0]wr_ptr,rd_ptr;
   reg wr_toggle_f,rd_toggle_f;
   reg [WIDTH-1:0]fifo[FIFO_SIZE-1:0];
   integer i;
   always@(posedge clk)begin
     if(res==1)begin
       full=0;
	   empty=1;
	   overflow = 0;
	   underflow=0;
	   rdata = 0;
	   wr_ptr=0;
	   rd_ptr=0;
	   wr_toggle_f = 0;
	   rd_toggle_f = 0;
	   for(i=0;i<FIFO_SIZE;i=i+1)fifo[i]=0;
     end
	else begin
	   if(wr_en==1)begin
	     if(full==1)begin
		   overflow=1;
		 end
		 else begin
		   fifo[wr_ptr] = wdata;
		   if(wr_ptr==FIFO_SIZE-1)begin
		       wr_ptr = 0;
			   wr_toggle_f = ~wr_toggle_f;
		      end
		   else wr_ptr = wr_ptr+1;
		  end
	   end
	   if(rd_en==1)begin
	      if(empty==1)begin
		     underflow = 1;
		  end
		  else begin
		     rdata = fifo[rd_ptr];
			 if(rd_ptr==FIFO_SIZE-1)begin
			   rd_ptr = 0;
			   rd_toggle_f = ~rd_toggle_f;
			   end
			 else rd_ptr = rd_ptr+1;
		  end
	   end
	end
end
always@(*)begin
   if(wr_ptr==rd_ptr && wr_toggle_f!=rd_toggle_f)full=1;
   else full = 0;
   if(wr_ptr==rd_ptr && wr_toggle_f==rd_toggle_f)empty=1;
   else empty=0;
end
endmodule
