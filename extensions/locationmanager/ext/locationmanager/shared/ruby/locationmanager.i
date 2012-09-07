/* locationmanager.i */
%module Locationmanager
%{
#include "ruby/ext/rho/rhoruby.h"

extern void locationmanager_init(void);
extern void locationmanager_get_heading(double *x, double *y, double *z, double *th);

#define init locationmanager_init
#define get_heading locationmanager_get_heading

%}

extern void init(void);
extern void get_heading(double *OUTPUT, double *OUTPUT, double *OUTPUT, double *OUTPUT);