-- author: connor (Connor!#0800 on shitcord)
util.require_natives(1640181023);
util.keep_running();

local wait = util.yield;
local root = menu.my_root()
menu.divider(root, "Femboy Tools");
local peds = menu.list(root, "Pedestrians", {"peds"}, "Spawn Pedestrians with ease!")
-- useful functions
local function get_player_coords()
    return ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))
end

-- global variables
give_spawned_ped_money = false
shoot_peds_to_sky = false
teleport_ped_to_each_player = false

-- ped-related stuff
menu.action(peds, "Spawn Agatha Baker", {"spawnagathabaker"}, "Spawns Agatha Baker on your player", function()
    -- util.toast("loading ped model");
    local coords = get_player_coords();
    -- util.toast('found player coords\n' .. coords.x .. ' ' .. coords.y .. ' ' .. coords.z);
    local hash = util.joaat('IG_Agatha')
    -- util.toast('loaded ped model' .. '' .. hash);
    STREAMING.REQUEST_MODEL(hash);
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        -- util.toast("waiting for model to load");
        util.yield();
    end
    -- util.toast("model loaded");
    local ped = PED.CREATE_PED(26, hash, coords.x, coords.y, coords.z, 0, 0, 0);
    -- util.toast('created ped\n' .. ped);
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash);
    if shoot_peds_to_sky then
        wait(1000);
    local new_coords = coords;
    new_coords.z = new_coords.z + 10;
    -- util.toast('teleporting ped to ' .. new_coords.x .. ' ' .. new_coords.y .. ' ' .. new_coords.z);
    PED.SET_PED_COORDS_NO_GANG(ped, new_coords.x, new_coords.y, new_coords.z, 0, 0, 0);
    -- util.toast('teleported ped');
    end
    if give_spawned_ped_money then
        -- util.toast('giving ped money');
        PED.SET_PED_MONEY(ped, 2000);
    end
end);

-- ped-related stuff (settings, "peds_settings")
local peds_settings = menu.list(peds, "Pedestrian Settings", {"ped_settings"}, "Manage how spawned pedestrians behave.")
menu.toggle(peds_settings, "Give Ped 2000 money", {"ped2kmoney"}, "Gives the spawned ped 2000 money (haha ez money. i dont recommend doing this though)", function(toggle)
    if toggle then
        give_spawned_ped_money = true;
    else
        give_spawned_ped_money = false;
    end
end);

menu.toggle(peds_settings, "Shoot Peds to Sky", {"shootpeds"}, "Shoots the spawned ped to the sky", function(toggle)
    if toggle then
        shoot_peds_to_sky = true;
    else
        shoot_peds_to_sky = false;
    end
end);

menu.toggle(peds_settings, "Ped teleports to each player (wip)", {"pedteleport"}, "Ped (with a railgun) teleports to each player in the session in an interval of 1 second", function(toggle)
    util.toast('this probably doesn\'t work yet')
    if toggle then
        teleport_ped_to_each_player = true
    else
        teleport_ped_to_each_player = false
    end
end);