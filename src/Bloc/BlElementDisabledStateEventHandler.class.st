Class {
	#name : #BlElementDisabledStateEventHandler,
	#superclass : #BlElementStateEventHandler,
	#category : #'Bloc-Core-State'
}

{ #category : #private }
BlElementDisabledStateEventHandler >> element: anElement enabled: aBoolean [
	aBoolean
		ifTrue: [ anElement states removeState: BlElementState disabled ]
		ifFalse: [ anElement states addState: BlElementState disabled ]
]

{ #category : #'api - accessing' }
BlElementDisabledStateEventHandler >> eventsToHandle [
	^ { BlElementDisabledStateWish }
]

{ #category : #'api - event managing' }
BlElementDisabledStateEventHandler >> handleEvent: aBlElementDisabledStateWish [
	self
		element: aBlElementDisabledStateWish currentTarget
		enabled: aBlElementDisabledStateWish enabled
]
