Scriptname RSCF_TriggerAliasBase extends ReferenceAlias
import Debug
Event OnTriggerLeave(ObjectReference akActionRef)
	Trace("I Have Left The Trigger")
EndEvent

Event OnUnload()
	Trace("I Have Unloaded")
EndEvent