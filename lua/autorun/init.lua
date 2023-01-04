LibC = LibC or {}

include("autorun/gcore_lib.lua");
AddCSLuaFile("autorun/gcore_lib.lua");


if SERVER then
    RunConsoleCommand("r_decals", "1000000");
    RunConsoleCommand("mp_decals", "1000000");

    RunConsoleCommand("sv_airaccelerate", "12");
    RunConsoleCommand("sv_maxvelocity", "3500");


    print("---------------------------------")
    print("| Loading ServerSide LibC |")
    print("---------------------------------")

    include('modules/init.lua');

    AddCSLuaFile('modules/cl_hud.lua');
    AddCSLuaFile('modules/cl_votemap.lua');

else
    print("---------------------------------")
    print("| Loading ClientSide LibC |")
    print("---------------------------------")

    include('modules/cl_hud.lua');
    include('modules/cl_votemap.lua');
end
 