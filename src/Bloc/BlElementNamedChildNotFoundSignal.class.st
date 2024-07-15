Class {
	#name : #BlElementNamedChildNotFoundSignal,
	#superclass : #BlElementSignal,
	#instVars : [
		'childName',
		'children'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #accessing }
BlElementNamedChildNotFoundSignal >> childName [
	^ childName
]

{ #category : #accessing }
BlElementNamedChildNotFoundSignal >> childName: anObject [
	childName := anObject
]

{ #category : #initialialize }
BlElementNamedChildNotFoundSignal >> prepareForDelivery [
	"I only store the stack when a concrete logger is interested in me"

	super prepareForDelivery.

	children := self element children asArray
]
