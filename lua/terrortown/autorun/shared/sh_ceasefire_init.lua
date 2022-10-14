if SERVER then
    resource.AddFile("materials/vgui/ttt/white_flag.png")
end

if CLIENT then
    -- Initialise status for sidebar-API
    hook.Add("Initialize", "ceasefire_init", function()
        STATUS:RegisterStatus("ceasefire_status", {
            -- sets the icon that will be rendered
            hud = Material("vgui/ttt/white_flag.png"),
            -- the type that defines the color, it can be 'good', 'bad' or 'default'
            type = "good"
        })
    end)
end
