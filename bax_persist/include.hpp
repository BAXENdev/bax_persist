
#define DEBUG
#define DEBUG2
#define PREFIX ("[BPST:" + _fnc_scriptName + ":" + #__LINE__ +"] ")
#define DLOG(MSG) diag_log (PREFIX + (MSG))
#define DLOG1(MSG, PARAM) diag_log format [(PREFIX + (MSG)), PARAM]
#define DLOG2(MSG, PARAM1, PARAM2) diag_log format [(PREFIX + (MSG)), PARAM1, PARAM2]
