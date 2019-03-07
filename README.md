# version-tester

## Usage
Download the bash script and create an app.csv file with your dependencies.
`./versions.bash` or `./versions.bash configfile.csv`


## Example app.csv
```
node,10.0.0,node --version
java,1.8.0,
docker,18.0.0,
python,2.7.10,
gcc,4,
g++,4,
pip,0,
php,0,
```

## Example Run
```
$ ./versions.bash

[PASS] node version v10.11.0 > 10.0.0
[PASS] java version 11.0.2 > 1.8.0
[PASS] docker version 18.09.2 > 18.0.0
[PASS] python version 2.7.10 > 2.7.10
[PASS] gcc version 4.2.1 > 4
[PASS] g++ version 4.2.1 > 4
[FAIL] pip version 0 is not found
[PASS] pip version null > 0
[PASS] php version 7.1.23 > 0
```
