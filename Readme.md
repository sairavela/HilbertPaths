# HilbertPaths

HilbertPaths generates a hilbert curve path plan to be placed into QGC.


## Usage

In the long_lat.m file, change the parameters as needed:
* order - Hilbert curve order
* distance - Length of one side of square area the curve will fill
* lat - Latitude of home position
* lon - Longitude for home position

The output will be a .txt file named 'positions.txt' containing coordinate of the way points. 

Then, run qgc_plan.py 
It will read the 'positions.txt' file and output the file plan as 'flightpath.txt' file of the path plan. 
No user input needed.

To place the path plan into QGC, convert .txt file into .plan file. 