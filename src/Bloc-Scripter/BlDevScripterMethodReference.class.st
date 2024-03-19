Class {
	#name : #BlDevScripterMethodReference,
	#superclass : #BlDevScripterReference,
	#instVars : [
		'definition',
		'interval'
	],
	#category : #'Bloc-Scripter-Scripter-Properties'
}

{ #category : #accessing }
BlDevScripterMethodReference >> definition [
	^ definition
]

{ #category : #accessing }
BlDevScripterMethodReference >> definition: anObject [
	definition := anObject
]

{ #category : #enumerating }
BlDevScripterMethodReference >> definitionDo: aBlock [
	aBlock value: self definition
]

{ #category : #printing }
BlDevScripterMethodReference >> gtDisplayOn: stream [
	self definition
		ifNil: [ super gtDisplayOn: stream.
			^ self ].

	self definition gtDisplayOn: stream
]

{ #category : #accessing }
BlDevScripterMethodReference >> interval [
	^ interval
]

{ #category : #accessing }
BlDevScripterMethodReference >> interval: anObject [
	interval := anObject
]
