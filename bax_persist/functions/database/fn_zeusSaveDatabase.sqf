
if (isServer) exitWith {};

missionProfileNamespace setVariable ["bax_persist_saveDate", bax_persist_saveDate];
missionProfileNamespace setVariable ["bax_persist_databasePlayers", bax_persist_databasePlayers];
missionProfileNamespace setVariable ["bax_persist_databaseObjects", bax_persist_databaseObjects];
missionProfileNamespace setVariable ["bax_persist_databaseVariables", bax_persist_databaseVariables];
missionProfileNamespace setVariable ["bax_persist_databaseInventories", bax_persist_databaseInventories];

saveMissionProfileNamespace;
