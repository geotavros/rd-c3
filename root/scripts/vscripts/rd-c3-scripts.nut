function Grubtus()
{
    if (activator != null && activator.IsValid())
    {
        activator.__KeyValueFromString("modelscale", "0.5");
    }
}

function GrubtusBig()
{
    if (activator != null && activator.IsValid())
    {
        activator.__KeyValueFromString("modelscale", "1.5");
    }
}

function Trolltus()
{
    if (activator != null && activator.IsValid())
    {
        activator.__KeyValueFromString("modelscale", "1.5");
    }
}

function FreezeMarines()
{    
    Convars.SetValue( "asw_marine_rolls", 0 );
    Convars.SetValue( "rd_marine_jump_height", 0 );
    
    Convars.SetValue( "asw_marine_speed_scale_easy", 0.001 );
    Convars.SetValue( "asw_marine_speed_scale_normal", 0.001 );
    Convars.SetValue( "asw_marine_speed_scale_hard", 0.001 );
    Convars.SetValue( "asw_marine_speed_scale_insane", 0.001 );
    Convars.SetValue( "asw_draw_hud", 0 );

    DoEntFire( "asw_marine", "RunScriptCode", "self.RemoveWeapon(0); self.RemoveWeapon(1); self.RemoveWeapon(2)", 0.0, null, null );

}

