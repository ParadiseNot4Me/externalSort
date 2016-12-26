External Sort
===================

Generate and external sort for large file.

Generate
===================

Generate file with size (mb).

Binary file:
```
./FileGenerator -b largeFile.txt 1000
```

Text file:
```
./FileGenerator -t largeFile.txt 1000
```

Sort
===================

External sort input file to output file with available memory (mb).

Binary file:
```
./ExternalSort -b largeFile.txt output.txt 100
```

Text file:
```
./ExternalSort -t largeFile.txt output.txt 100
```

