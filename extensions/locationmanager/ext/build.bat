
if "%RHO_PLATFORM%" == "android" (

cd locationmanager\platform\android
rake --trace

)

if "%RHO_PLATFORM%" == "iphone" (

cd locationmanager\platform\phone
rake --trace

)

if "%RHO_PLATFORM%" == "wm" (

cd locationmanager\platform\wm
rake --trace

)

if "%RHO_PLATFORM%" == "win32" (

cd locationmanager\platform\wm
rake --trace

)

if "%RHO_PLATFORM%" == "bb" (

cd locationmanager\platform\bb
rake --trace

)

