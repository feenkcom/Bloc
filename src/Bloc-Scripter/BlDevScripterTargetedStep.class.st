Class {
	#name : #BlDevScripterTargetedStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterTargetedStep >> defaultTarget [
	^ BlDevScripterSelfEventTarget new
]

{ #category : #'targets - accessing and updating' }
BlDevScripterTargetedStep >> target [
	<return: #BlScripterElementTarget>

	^ target ifNil: [ target := self defaultTarget ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterTargetedStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]
