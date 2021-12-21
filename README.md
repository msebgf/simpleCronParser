# A simplified cron parser

## Requirements
- Swift 5.5
- Command line tools

## How to Run

- Create a file locate it in the root of the project (same level as package.swift) with the tast for the cron parser in this format:

```
30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times
``` 

- In the root of the project run the command 
`cat <inputFile> | swift run Scheduler <simulatedTime>`
	- inputFile is the file containing the information for the cron parser
	- simulatedTime the simulated time to run the cron parser in format **HH:mm**
	- Example:
	`swift run testFile.txt 16:10`
	


## Notes
