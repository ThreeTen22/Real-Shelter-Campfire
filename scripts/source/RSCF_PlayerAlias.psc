Scriptname RSCF_PlayerAlias extends ReferenceAlias

Event OnPlayerLoadGame()
	(GetOwningQuest() as RSCF_MainQuest).OngameReload()
EndEvent