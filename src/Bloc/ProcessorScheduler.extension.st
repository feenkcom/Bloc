Extension { #name : #ProcessorScheduler }

{ #category : #'*Bloc' }
ProcessorScheduler >> gtNextReadyProcess [
	quiescentProcessLists reverseDo: [ :list |
		list firstOrNil ifNotNil: [ :proc |
			proc suspendedContext ifNotNil: [ ^proc ]]].
	^nil
]

{ #category : #'*Bloc' }
ProcessorScheduler >> isBlocUIProcess [
	^ BlHostPulseLoopMarker isUIProcess
]
