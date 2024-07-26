
Loading Perl Modules Dynamically
================================

This is a simple example of how to load Perl modules dynamically. This is useful when you want to load a module based on a configuration file or a command line argument.

It is rather challenging to get this right, because Perl has a lot of ways to load modules, and some of them are not very well documented. 
This example shows how to load a module using the `require` function, which is the most reliable way to load a module dynamically.

The example consists of the following files:

.
├── lib
│   ├── MyPackage.pm
│   └── NewPackage.pm
├── load-module-dynamic.pl
└── README.md

1 directory, 4 files

The `lib` directory contains two Perl modules: `MyPackage.pm` and `NewPackage.pm`. 
The `load-module-dynamic.pl` script loads one of these modules based on a command line argument.

To run the example, use the following command:

```text
./load-module-dynamic.pl 
```

The script first load the `MyPackage` module, and then the `NewPackage` module.

The `get_var()` function appears in both modules, but it is implemented differently in each module.

example:

```text
  fqn: this sub should be automatically exported from MyPackage
local: this sub should be automatically exported from MyPackage
this sub is ok to export from MyPackage
var_exported: MyPackage: this var should be automatically exported
=============================================
  fqn: this sub should be automatically exported from NewPackage
local: this sub should be automatically exported from NewPackage
this sub is ok to export from NewPackage
var_exported: NewPackage: this var should be automatically exported
```

Although the functions in each modules should be automactically exported, that does not seem to be working at this time.

So, the functions are all explicitly loaded in the import() function.


