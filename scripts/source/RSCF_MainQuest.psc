Scriptname RSCF_MainQuest extends Quest  
import Game
import Utility
import Debug
Activator Property RSCF_PlacementSystemManager Auto
ReferenceAlias Property RSCF_TBTracker1 Auto

Event OnInit()
	OnGameReload()
EndEvent

Function OnGameReload()
	RegisterForModEvent("Campfire_OnObjectPlaced", "Campfire_OnObjectPlaced")
	RegisterForModEvent("Campfire_OnObjectRemoved", "Campfire_OnObjectRemoved")
	RegisterForModEvent("Campfire_OnTentEnter", "Campfire_OnTentEnter")
	RegisterForModEvent("Campfire_OnTentLeave", "Campfire_OnTentLeave")
EndFunction

Event Campfire_OnObjectPlaced(Form akObjectReference, Float px,Float py,Float pz,Float ax,Float ay,Float az, bool abIsTent)
		Int x = 5
		Bool usesTB = false
		Trace("RS: Entered OnObjectPlaced")
		If abIsTent == false
			;RSCF_SpawnSystem akPlacementManager = ((akObjectReference as ObjectReference).PlaceAtMe(RSCF_PlacementSystemManager,1,false,true) as RSCF_SpawnSystem)
			;If akPlacementManager
			Trace("RS: This is a Tent")
				ObjectReference campTrigger
				Activator tbActivator = (akObjectReference as CampTent).TentAsset_LargeTentTriggerVolume
				If tbActivator
					usesTB = true
					While x > 0
						Trace("RS: Entered While Loop")
						Wait(1)
						campTrigger = FindClosestReferenceOfType(tbActivator, px,py,pz,39)
						If campTrigger
							RSCF_TBTracker1.ForceRefTo(campTrigger)
							x = 0
						EndIf
						x-=1
					EndWhile
				EndIf
				campTrigger = none
			;EndIf
			;akPlacementManager = none
		EndIf
		Trace("RS: Leaving OnObjectPlaced")
EndEvent

Event Campfire_OnObjectRemoved(Form akBaseObject, float pX, float pY, float pZ, float aX, float aY, float aZ, bool abIsTent)
        If abIsTent == false
                debug.trace("The player just removed a tent!")
        Endif
EndEvent



Event Campfire_OnTentEnter(Form akTent, bool abHasShelter)
        If abHasShelter
                debug.trace("It's going to be a cold night...")
        Endif
EndEvent

