Class {
	#name : #BlElementStateEventHandler,
	#superclass : #BlCustomEventHandler,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Core-State'
}

{ #category : #accessing }
BlElementStateEventHandler class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
