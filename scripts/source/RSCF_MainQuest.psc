Scriptname RSCF_MainQuest extends Quest  

Function OnGameReload()
	RegisterForModEvent("Campfire_OnObjectPlaced", "Campfire_OnObjectPlaced")
	RegisterForModEvent("Campfire_OnObjectRemoved", "Campfire_OnObjectRemoved")
EndFunction

Event Campfire_OnObjectPlaced(Form akObjectReference, Float px,Float py,Float pz,Float ax,Float ay,Float az , bool abIsTent)

EndEvent

Event Campfire_OnObjectRemoved(Form akBaseObject, float pX, float pY, float pZ, float aX, float aY, float aZ, bool abIsTent)
        if abIsTent
                debug.trace("The player just placed a tent!")
        endif
endEvent
