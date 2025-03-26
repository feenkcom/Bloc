Trait {
	#name : #TSignalNonUIProcess,
	#category : #'Bloc-Utilities - Debugging'
}

{ #category : #debugging }
TSignalNonUIProcess >> checkInUIProcess [
	"Emit a BlNonUIProcessSignal signal if we aren't in a UI process"
	
	| aCurrentProcess aUIProcess |
	self isAttachedToSceneGraph ifFalse: [ ^ self ].

	self space isOpened ifFalse: [ ^ self ].

	aCurrentProcess := Processor activeProcess.

	aUIProcess := nil.
	self space host uiProcessDo: [ :aProcess | aUIProcess := aProcess ].

	(aUIProcess isNil or: [ aCurrentProcess == aUIProcess ]) ifTrue: [ ^ self ].

	BlNonUIProcessSignal emit
]
