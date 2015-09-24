Scriptname RSCF_SpawnSystem extends ObjectReference  

Int Property Type = 0 Auto Hidden
Bool Property isReady = false Auto Hidden

Event OnInit()
	Utility.Wait(2)
	Debug.Trace(self + " FinishedOnInit")
	isReady = true
EndEvent

Event OnUnload()
EndEvent

Event OnUpdate()
EndEvent

State Init
	Event OnLoad()
		Debug.Trace("RS: I Have Loaded - "+Type+ " "+self)
		GotoState("Ready")
	EndEvent
EndState


State Active
	Event OnBeginState()
		Debug.Trace("RS: OnBeginState - Active: "+self)
		isReady = false
		RegisterForSingleUpdate(0.001)
	EndEvent

	Event OnUpdate()
		Utility.Wait(1)
		Debug.Trace("RS: OnUpdate - Active: EndOfOnUpdate"+self)
		isReady = true
	EndEvent
EndState

State Shutdown
	Event OnBeginState()
		isReady = false
		Debug.Trace("RS: OnBeginState - Shutdown: "+self)
		RegisterForSingleUpdate(0.001)
	EndEvent

	Event OnUpdate()
		Utility.Wait(1)
		Debug.Trace("RS: OnUpdate - Shutdown: EndOfOnUpdate"+self)
		isReady = true
	EndEvent

EndState