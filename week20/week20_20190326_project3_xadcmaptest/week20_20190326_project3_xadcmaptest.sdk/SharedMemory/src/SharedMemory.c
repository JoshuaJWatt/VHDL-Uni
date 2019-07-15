#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "xparameters.h"
#include "xil_types.h"
#include "xstatus.h"
#include "xil_testmem.h"
#include <math.h>
#include "xuartlite.h"
#include "xuartlite_l.h"

int main()
{
	init_platform();
	/*Variables*/
	unsigned int leds;
	u32* pshared;
	/*-------------*/

	leds = 21;
	pshared = XPAR_BRAM_0_BASEADDR;

	*pshared = (u32)leds;

	cleanup_platform();
	return 0;
}


