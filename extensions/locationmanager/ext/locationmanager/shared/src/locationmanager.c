#ifdef __cplusplus
extern "C" {
#endif

// declare Ruby registration method generated by SWIG in locationmanager_wrap.c
extern void Init_Locationmanager(void);

// this method executed once on start of program
void Init_Locationmanager_extension(void) {
	// execute initialization of Ruby registration (generated by SWIG)
	Init_Locationmanager();

	// You can add some code to this place:


}

#ifdef __cplusplus
} //extern "C"
#endif