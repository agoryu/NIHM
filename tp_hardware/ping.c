#include <gpio.h>
#include <FreeRTOS.h>
#include <task.h>
#include <timer.h>
#include <timers.h>
#include <malloc.h>

uint32_t period = 350;
uint16_t prescale = 256;
int direction;
int nbLeds = 5;
pin_t* litLed;
int idxLed;
int hasPlayed;

pin_t j1, j2;
pin_t *leds, *players;

xTimerHandle timer;


static void handlePlayersInputs(void *p);
//~ static void startGame(void *p);
void vTimerCallback( xTimerHandle pxTimer );

int main() {
    //Initialize the pin_t structure with the pin port and number
    //On this board there is a LED on PG13
    
    j1 = make_pin(GPIO_PORT_A, 5);
    gpio_config(j1, pin_dir_read, pull_down);
    
    j2 = make_pin(GPIO_PORT_C, 3);
    gpio_config(j2, pin_dir_read, pull_down);
    
    pin_t led1 = make_pin(GPIO_PORT_B, 7);
    gpio_config(led1, pin_dir_write, pull_down);
    
    pin_t led2 = make_pin(GPIO_PORT_E, 2);
    gpio_config(led2, pin_dir_write, pull_down);
    
    pin_t led3 = make_pin(GPIO_PORT_E, 4);
    gpio_config(led3, pin_dir_write, pull_down);
	
    pin_t led4 = make_pin(GPIO_PORT_E, 5);
    gpio_config(led4, pin_dir_write, pull_down);
	
    pin_t led5 = make_pin(GPIO_PORT_E, 6);
    gpio_config(led5, pin_dir_write, pull_down);
    
    gpio_set(led1, 1);
    gpio_set(led2, 0);
    gpio_set(led3, 0);
    gpio_set(led4, 0);
    gpio_set(led5, 0);
    
    pin_t* leds = (pin_t*) malloc(5*sizeof(pin_t));
    pin_t* players = (pin_t*) malloc(2*sizeof(pin_t));
    
    players[0] = j1;
    players[1] = j2;
    leds[0] = led1;
    leds[1] = led2;
    leds[2] = led3;
    leds[3] = led4;
    leds[4] = led5;
    
    litLed = leds;
    idxLed = 0;
    direction = 1;
    
    timer = xTimerCreate(NULL, period, pdTRUE, NULL, vTimerCallback);
    
    /*xTaskCreate(startGame,
    (signed char *) "nom", 
    configMINIMAL_STACK_SIZE, 
    NULL, 
    tskIDLE_PRIORITY, 
    NULL);*/
    
    xTaskCreate(handlePlayersInputs,
    (signed char *) "tata", 
    configMINIMAL_STACK_SIZE, 
    NULL, 
    tskIDLE_PRIORITY, 
    NULL);
    
    while(1)
	{
		if (gpio_get(players[0]) == 1)
			break;
	}
	
	hasPlayed = 1;
	xTimerStart(timer, 0);
    
    vTaskStartScheduler();
    
    return 0;
}

void vTimerCallback( xTimerHandle pxTimer )
{
	gpio_set(*litLed, 0);
	litLed += direction;
	idxLed += direction;
	gpio_set(*litLed, 1);
	
	if (idxLed == nbLeds - 1)
		direction = -1;
		
	if (idxLed == 0)
		direction = 1;
		
	if ((idxLed == 1 && direction == 1) || (idxLed == nbLeds - 3 && direction == -1))
	{
		if (hasPlayed == 1)
		{
			hasPlayed = 0;
		}
		else
		{
			gpio_set(*litLed, 0);
			gpio_set((idxLed == 1 ? leds[nbLeds-1] : leds[0]), 1);
			xTimerStop(timer, 0);
		}
	}
}

//~ static void startGame(void *p)
//~ {
	//~ while(1)
	//~ {
		//~ if (gpio_get(players[0]) == 1)
			//~ break;
	//~ }
	//~ 
	//~ hasPlayed = 1;
	//~ xTimerStart(timer, 0);
	//~ 
	//~ return;
//~ }

static void handlePlayersInputs(void *p)
{
	while(1)
	{
		if (gpio_get(j1) == 1 && idxLed == 0)
			hasPlayed = 1;
		
		if (gpio_get(j2) == 1 && idxLed == nbLeds - 1)
			hasPlayed = 1;
	}
}

/*static void lightLed(void *p)
{
	pin_t *led = p;
	pin_t *btn = p + sizeof(pin_t);
	
	while (1)
	{
		gpio_set(*led, gpio_get(*btn));
	}
}
*/
