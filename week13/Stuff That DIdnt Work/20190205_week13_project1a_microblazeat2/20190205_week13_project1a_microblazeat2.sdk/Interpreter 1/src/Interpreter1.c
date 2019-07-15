/*Includes & Defines*/
#include <stdio.h>
#include <stdlib.h>
#include "xparameters.h"
#include "xil_types.h"
#include "xstatus.h"
#include "xil_testmem.h"
#include <math.h>
#include "xuartlite.h"
#include "xuartlite_l.h"

#define XPAR_BRAM_0_BASEADDR 0xC0000000
#define COMMAND_BUFFER_LENGTH 200
/*---------------------------------*/
int main()
{
    init_platform();
    /* Variables */
    int charcount;
    int gain;
    char cmdbuffer[COMMAND_BUFFER_LENGTH];
    char input;
    char* valstart;
    /*-------------*/

    while(1)
    {
    	xil_printf("\r\n$ ");
    	charcount = 0;
    	while(charcount < COMMAND_BUFFER_LENGTH)
    	{
    		input = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR); /*Code to receive character*/

    		if(input == (char)'\r') /*For Return*/
    		{
    			/*End memory usage with terminate character*/
    			cmdbuffer[charcount]='\0';

    			/*Interpret inputs into commands*/
    			if(strstr(cmdbuffer, "gain")!=0)
    			{
    				valstart = strstr(cmdbuffer, "=") +1;
    				gain = atoi(valstart);
    			}

    			/*Reset character buffer to 0*/
    			charcount = 0;

    			/*New line and prompt*/
    			xil_printf("\r\n$ ");
    		}
    		else /*For all other characters*/
    		{
    			xil_printf("%c",(char)input);
    			cmdbuffer[charcount] = (char)input;
    			++charcount;
    		}
    	}
    	xil_printf("Command buffer full. Resetting it \r\n");
    }

    cleanup_platform();
    return 0;
}
