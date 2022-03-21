-- author: connor (Connor!#0800 on shitcord)
util.require_natives(1640181023);
util.keep_running();

local wait = util.yield;

local root = menu.my_root()
local function get_player_coords()
    return ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))
end

menu.divider(root, "main");

menu.action(root, "spawn ped", {"pedspawn"}, "spawns a pedestrian on your player", function()
    util.toast("loading ped model");
    local coords = get_player_coords();
    util.toast('found player coords\n' .. coords.x .. ' ' .. coords.y .. ' ' .. coords.z);
    local hash = util.joaat('IG_Agatha')
    util.toast('loaded ped model' .. '' .. hash);
    STREAMING.REQUEST_MODEL(hash);
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.toast("waiting for model to load");
        util.yield();
    end
    util.toast("model loaded");
    local ped = PED.CREATE_PED(26, hash, coords.x, coords.y, coords.z, 0, 0, 0);
    util.toast('created ped\n' .. ped);
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash);
    wait(1000);
    local new_coords = coords;
    new_coords.z = new_coords.z + 10;
    util.toast('teleporting ped to ' .. new_coords.x .. ' ' .. new_coords.y .. ' ' .. new_coords.z);
    PED.SET_PED_COORDS_NO_GANG(ped, new_coords.x, new_coords.y, new_coords.z, 0, 0, 0);
    util.toast('teleported ped');
    PED.SET_PED_MONEY(ped, 2000); -- we do a little trolling here
end);