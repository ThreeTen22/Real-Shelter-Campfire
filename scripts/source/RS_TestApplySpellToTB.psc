Scriptname RS_TestApplySpellToTB extends Quest  

Spell Property RS_TentTriggerSP Auto

Event OnInit()
	RegisterForModEvent("Campfire_OnObjectPlaced","Campfire_OnObjectPlaced")
EndEvent

Event Campfire_OnObjectPlaced(Form akObjectReference, Float px,Float py,Float pz,Float ax,Float ay,Float az , bool abIsTent)
	Debug.Trace("RS:  Placing Object: "+ akObjectReference)
	Int Counter = 5
	If (akObjectReference as CampTent)
		Activator TentTB = (akObjectReference as CampTent).TentAsset_LargeTentTriggerVolume
		If TentTB
			While Counter > 0
				Utility.Wait(1)
				If (akObjectReference as CampTent).myLargeTentTriggerVolume
					Counter = 0
					Debug.Trace("RS:  Placing Object: " + (akObjectReference as CampTent).myLargeTentTriggerVolume)
					RS_TentTriggerSP.Cast((akObjectReference as CampTent).myLargeTentTriggerVolume)
					RS_TentTriggerSP.Cast(Game.GetPlayer())
				EndIf
				Counter+=(-1)
			EndWhile
			TentTB = none
		EndIf
	EndIf
EndEvent
;CampLargeTentTriggerVolumeScript