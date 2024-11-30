
if (isServer) exitWith {};

_saveData = _this;
missionProfileNamespace setVariable ["bax_persist_saveData", _saveData];
saveMissionProfileNamespace;
