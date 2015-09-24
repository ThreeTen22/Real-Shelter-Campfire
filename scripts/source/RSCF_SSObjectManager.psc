Scriptname RSCF_SSObjectManager extends ObjectReference

Activator Property RSCF_PlacementHelperLeft Auto
Activator Property RSCF_PlacementHelperRight Auto
ObjectReference Property akPHL Auto Hidden
ObjectReference Property akPHR Auto Hidden

Bool Property isReady = false Auto Hidden

Event OnInit()
	GoToState("Init")
	akPHR = PlaceAtMe(RSCF_PlacementHelperRight, 1, false, true)
	akPHL = PlaceAtMe(RSCF_PlacementHelperLeft, 1, false, true)
	(akPHR as RSCF_SpawnSystem).Type = 1
	(akPHL as RSCF_SpawnSystem).Type = 2
	(akPHR as RSCF_SpawnSystem).GoToState("Init")
	(akPHL as RSCF_SpawnSystem).GoToState("Init")
	EnableNoWait()
EndEvent

State Init
	Event OnLoad()
		Debug.Trace("RS: I Have Loaded - "+self)
		If (akPHR as RSCF_SpawnSystem).isReady
			akPHR.EnableNoWait()
		EndIf
		If (akPHL as RSCF_SpawnSystem).isReady
			akPHL.EnableNoWait()
		EndIf
		isReady = true
	EndEvent
EndState

State Active
	Event OnBeginState()
		isReady = false
		Debug.Trace("RS: OnBeginState - Active: "+self)
		RegisterForSingleUpdate(0.001)
	EndEvent

	Event OnUpdate()
		akPHR.GoToState("Active")
		akPHL.GoToState("Active")
		While (akPHR as RSCF_SpawnSystem).isReady == false
			Utility.Wait(0.1)
		EndWhile
		While (akPHL as RSCF_SpawnSystem).isReady == false
			Utility.Wait(0.1)
		EndWhile
		isReady = true
		Debug.Trace("RS: OnUpdate - Active: EndOfOnUpdate "+self)
	EndEvent

EndState


State Shutdown
	Event OnBeginState()
		isReady = false
		Debug.Trace("RS: OnBeginState - Shutdown: "+self)
		RegisterForSingleUpdate(0.001)
	EndEvent

	Event OnUpdate()
		akPHR.GoToState("Shutdown")
		akPHL.GoToState("Shutdown")
		While (akPHR as RSCF_SpawnSystem).isReady == false
			Utility.Wait(0.1)
		EndWhile
		While (akPHL as RSCF_SpawnSystem).isReady == false
			Utility.Wait(0.1)
		EndWhile		
		isReady = true
		Debug.Trace("RS: OnUpdate - Shutdown: EndOfOnUpdate "+self)
	EndEvent
EndState