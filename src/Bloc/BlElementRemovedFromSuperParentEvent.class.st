Class {
	#name : #BlElementRemovedFromSuperParentEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'parent',
		'element'
	],
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementRemovedFromSuperParentEvent class >> enableIn: anObject [
	anObject enableRemovedFromSuperParent
]

{ #category : #'api - enable / disable' }
BlElementRemovedFromSuperParentEvent class >> wantedIn: anObject [
	^ anObject wantsRemovedFromSuperParent
]

{ #category : #accessing }
BlElementRemovedFromSuperParentEvent >> element [

	^ element
]

{ #category : #accessing }
BlElementRemovedFromSuperParentEvent >> element: anObject [

	element := anObject
]

{ #category : #accessing }
BlElementRemovedFromSuperParentEvent >> parent [

	^ parent
]

{ #category : #accessing }
BlElementRemovedFromSuperParentEvent >> parent: anObject [

	parent := anObject
]

{ #category : #sending }
BlElementRemovedFromSuperParentEvent >> sendTo: anObject [
	anObject elementRemovedFromSuperParentEvent: self
]
