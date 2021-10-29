Class {
	#name : #BlElementAddedToSuperParentEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'parent'
	],
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementAddedToSuperParentEvent class >> enableIn: anObject [
	anObject enableAddedToSuperParent
]

{ #category : #'api - enable / disable' }
BlElementAddedToSuperParentEvent class >> wantedIn: anObject [
	^ anObject wantsAddedToSuperParent
]

{ #category : #accessing }
BlElementAddedToSuperParentEvent >> parent [

	^ parent
]

{ #category : #accessing }
BlElementAddedToSuperParentEvent >> parent: anObject [

	parent := anObject
]

{ #category : #sending }
BlElementAddedToSuperParentEvent >> sendTo: anObject [
	anObject elementAddedToSuperParentEvent: self
]
