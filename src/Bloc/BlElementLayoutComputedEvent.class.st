"
Is sent when elemen't layout is computed, see {{gtMethod:BlElement>>#onLayoutDone}}
"
Class {
	#name : #BlElementLayoutComputedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementLayoutComputedEvent class >> enableIn: anObject [
	anObject enableLayoutComputed
]

{ #category : #'api - enable / disable' }
BlElementLayoutComputedEvent class >> wantedIn: anObject [
	^ anObject wantsLayoutComputed
]

{ #category : #sending }
BlElementLayoutComputedEvent >> sendTo: anObject [
	anObject elementLayoutComputedEvent: self
]
