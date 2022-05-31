Class {
	#name : #BlKeyboardKeyTable,
	#superclass : #Object,
	#category : #'Bloc-Universe'
}

{ #category : #initialization }
BlKeyboardKeyTable >> initialize: aMapDictionary with: aMapArray [
	aMapArray
		pairsDo: [ :eachCode :eachName | 
			| aName aKey |
			aKey := [ BlKeyboardKey eachName ] onErrorDo: [ :ex | nil ].
			aKey isNil
				ifTrue: [ aKey := [ BlKeyboardKey eachName uncapitalized ] onErrorDo: [ :ex | nil ] ].
			aKey isNil ifTrue: [ aKey := BlKeyboardKey unknown ].

			aMapDictionary at: eachCode put: (aKey setValue: eachCode) ]
]

{ #category : #initialization }
BlKeyboardKeyTable >> initialize: aMapDictionary withKeys: aMapArray [
	aMapArray pairsDo: [ :eachCode :eachKey |
		aMapDictionary at: eachCode put: (eachKey copy setValue: eachCode) ]
]

{ #category : #'api - converting' }
BlKeyboardKeyTable >> keyFromVirtualCode: aScanCode [
	<return: #BlKeyboardKey>

	^ self subclassResponsibility
]
