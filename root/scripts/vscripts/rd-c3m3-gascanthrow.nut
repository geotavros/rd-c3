// vector math bs
function DegToRad( ang )
{
	return ang / 57.2958;
}

function NormalizeVector( vec )
{
    local vecOutput = Vector( 0.0, 0.0, 0.0 );
	local mod = 0.0;

	foreach( dir in vec )
        mod += dir * dir;

    local mag = pow( mod, 0.5 );

    if ( mag == 0.0 )
		return vecOutput;

	vecOutput.x = vec.x / mag;
	vecOutput.y = vec.y / mag;
	vecOutput.z = vec.z / mag;

    return vecOutput;
}

function GetYawFromVector( vec )
{
	local nSign = vec.y < 0.0 ? -1 : 1;

	vec = NormalizeVector( vec );

	return 57.2958 * acos( vec.x ) * nSign;
}

function GetNormalizedVectorFromAngles( vecAngles )
{
	local fPitch = -DegToRad( vecAngles.x );
	local fYaw = DegToRad( vecAngles.y );
	
	return Vector( cos( fPitch ) * cos( fYaw ), sin( fYaw ) * cos( fPitch ), sin( fPitch ) );
}

// end of vector math bs

hParentPrev <- null;

function Think()
{
	if (!self) {
		return;
	}
	local hParent = self.GetMoveParent();
	if ( !hParentPrev && hParent )
	{
		hParentPrev <- hParent;
		PickedUp( hParent );
		
		return;
	}
	
	if ( hParentPrev && !hParent )
	{
		if ( !hParentPrev.IsValid() || hParentPrev.GetHealth() <= 0 )
		{
			CarrierDied();
			hParentPrev <- null;
			
			return;
		}
		
		Thrown( hParentPrev );
		hParentPrev <- null;
	}
	
	return 0.03;
}

function PickedUp( hMarine )
{
	//ClientPrint( null, 3, hMarine + " pickedup item" );
}

function CarrierDied()
{
	//ClientPrint( null, 3, "item carrier died" );
}

function Thrown( hMarine )
{
	//ClientPrint( null, 3, hMarine + " threw item" );
	
	local vecAngles = hMarine.GetAngles();
	local vecThrow = GetNormalizedVectorFromAngles( vecAngles );
	local fThrowSpeed = 200.0;
	
	vecThrow.x *= fThrowSpeed;
	vecThrow.y *= fThrowSpeed;
	vecThrow.z = 200.0;
	
	local vecMarineVelocityAdd = hMarine.GetVelocity();
	local fMarineVelocityFactor = 0.5;
	vecMarineVelocityAdd.x *= fMarineVelocityFactor;
	vecMarineVelocityAdd.y *= fMarineVelocityFactor;
	vecMarineVelocityAdd.z = 0.0;
	
	self.SetVelocity( vecThrow + vecMarineVelocityAdd );
}

AddThinkToEnt( self, "Think" );