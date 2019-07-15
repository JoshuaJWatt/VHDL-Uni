/*CmdPromptPrint.c*/

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

#define COMMAND_BUFFER_LENGTH 200
/*---------------------------------*/
int main()
{
    init_platform();
    /* Variables */
    int charcount;
    char cmdbuffer[COMMAND_BUFFER_LENGTH];
    char input;
    int gain;
    char* valstart;
    /*-------------*/

    xil_printf("\r\n$ ");
    while(1)
    {
    	input = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);
    	if(input == (char)'\r') /*For Return*/
    	{
    		xil_printf("\r\n$ ");
    	}
    	else /*For all other characters*/
   		{
    		xil_printf("%c",(char)input);
    	}
   	}

    cleanup_platform();
    return 0;
}
