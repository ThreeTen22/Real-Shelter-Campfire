Scriptname RSCF_MainQuest extends Quest  
import Game
import Utility
import Debug
Activator Property RSCF_PlacementSystemManager Auto
ReferenceAlias Property RSCF_TBTracker1 Auto
ObjectReference Property akCurrentPlacementManager Auto Hidden

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
		Bool usesTB = false
		Trace("RS: Entered OnObjectPlaced")
		If (akObjectReference as CampTent) == true
			Trace("RS: This is a Tent")
			RSCF_SSObjectManager akPlacementManager = ((akObjectReference as ObjectReference).PlaceAtMe(RSCF_PlacementSystemManager,1,false,true) as RSCF_SSObjectManager)
			If akPlacementManager	
				Activator tbActivator = (akObjectReference as CampTent).TentAsset_LargeTentTriggerVolume
				If tbActivator
					usesTB = true
				EndIf
			EndIf
			akPlacementManager = none
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
        	Trace("RS: OnTentEnter: Entered Function")
           	Activator tbActivator = (akTent as CampTent).TentAsset_LargeTentTriggerVolume
			Trace("RS: OnTentEnter: Checking For akCurrentPlacementManager")
			akCurrentPlacementManager = FindClosestReferenceOfTypeFromRef(RSCF_PlacementSystemManager,(akTent as ObjectReference),500)
			If akCurrentPlacementManager
				Trace("RS: OnTentEnter: Found" + akCurrentPlacementManager)
				While (akCurrentPlacementManager as RSCF_SSObjectManager).isReady == false
					Wait(0.1)
				EndWhile
				akCurrentPlacementManager.GoToState("Active")
			EndIf
				;(RSCF_TBTracker1 as RSCF_TriggerAliasBase).SetInfo(akCurrentPlacementManager)
				;RSCF_TBTracker1.ForceRefTo(akCampTrigger)
        Endif
EndEvent


Event Campfire_OnTentLeave()
	If akCurrentPlacementManager
		While (akCurrentPlacementManager as RSCF_SSObjectManager).isReady == false
			Wait(0.1)
		EndWhile
		akCurrentPlacementManager.GotoState("Shutdown")
		akCurrentPlacementManager = none
	EndIf
EndEvent