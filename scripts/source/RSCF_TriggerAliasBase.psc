Scriptname RSCF_TriggerAliasBase extends ReferenceAlias
import Debug

ObjectReference Property akPlacementManager Auto hidden

Event OnTriggerLeave(ObjectReference akActionRef)
	Trace("I Have Left The Trigger")
	akPlacementManager = none
	Clear()
EndEvent

Event OnUnload()
	akPlacementManager = none
	Clear()
EndEvent

Function SetInfo(ObjectReference akPM)
	akPlacementManager = akPM
	Trace("RS: I have been Given Info " + self + " " + akPlacementManager)
EndFunction