"
I provide {{gtClass:GtPhlowView|label=views}} displaying {{gtClass:BlDevScripter}} information within an inspected {{gtClass:Exception}}.

"
Trait {
	#name : #TBlDevScripterException,
	#instVars : [
		'scripter',
		'exception'
	],
	#category : #'Bloc-Scripter-Scripter-Exceptions'
}

{ #category : #'api - accessing' }
TBlDevScripterException >> exception [
	^ exception
]

{ #category : #'api - accessing' }
TBlDevScripterException >> exception: anObject [
	exception := anObject
]

{ #category : #'api - accessing' }
TBlDevScripterException >> passWithScripter: aScripter [
	self pass
]

{ #category : #printing }
TBlDevScripterException >> printOn: aStream [
	self exception ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Scripter ';
		print: self exception
]

{ #category : #'api - accessing' }
TBlDevScripterException >> scripter [
	^ scripter
]

{ #category : #'api - accessing' }
TBlDevScripterException >> scripter: anObject [
	scripter := anObject
]
