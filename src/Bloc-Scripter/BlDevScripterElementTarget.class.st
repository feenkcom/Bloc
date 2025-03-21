"
I perform steps on a specific {{gtClass:BlElement}} instance.
"
Class {
	#name : #BlDevScripterElementTarget,
	#superclass : #BlDevScripterTarget,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #accessing }
BlDevScripterElementTarget >> element [
	^ element
]

{ #category : #accessing }
BlDevScripterElementTarget >> element: anObject [
	element := anObject
]

{ #category : #searching }
BlDevScripterElementTarget >> findTargetIn: anElement [
	<return: #BlElement>
	^ self element
]

{ #category : #searching }
BlDevScripterElementTarget >> findTargetStartingInScripter: aScripter [
	^ self element
]

{ #category : #accessing }
BlDevScripterElementTarget >> identifier [
	^ 'element'
]

{ #category : #printing }
BlDevScripterElementTarget >> printOn: aStream [
	aStream
		nextPutAll: 'Element: ';
		print: self element
]
