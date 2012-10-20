
if "%RHO_PLATFORM%" == "android" (

cd accelerometer\platform\android
rake --trace

)

if "%RHO_PLATFORM%" == "iphone" (

cd accelerometer\platform\phone
rake --trace

)

if "%RHO_PLATFORM%" == "wm" (

cd accelerometer\platform\wm
rake --trace

)

if "%RHO_PLATFORM%" == "win32" (

cd accelerometer\platform\wm
rake --trace

)

if "%RHO_PLATFORM%" == "bb" (

cd accelerometer\platform\bb
rake --trace

)

