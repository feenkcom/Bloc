Class {
	#name : #BlElementRepaintRequestedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementRepaintRequestedEvent class >> enableIn: anObject [
	anObject enableRepaintRequested
]

{ #category : #'api - enable / disable' }
BlElementRepaintRequestedEvent class >> wantedIn: anObject [
	^ anObject wantsRepaintRequested
]

{ #category : #sending }
BlElementRepaintRequestedEvent >> sendTo: anObject [
	anObject elementRepaintRequestedEvent: self
]
